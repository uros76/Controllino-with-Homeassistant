#!/bin/bash
# https://docs.projectquay.io/api_quay.html#_tag, Max 100/page

MINER=miner
REGION=EU868
GWPORT=1680
MINERPORT=44158
DATADIR=/home/pi/miner_data
LOGDIR=/var/log/miner
GA=GA

function find_tags() {
  curl -s "https://quay.io/api/v1/repository/team-helium/miner/tag/?limit=$1&page=1&onlyActiveTags=true" \
    -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.88 Safari/537.36' \
    -H 'x-requested-with: XMLHttpRequest' | grep -Po 'miner-arm64_[0-9]+\.[0-9]+\.[0-9]+\.[^"]+_GA' | sort -n | tail -1
}

CL_MINER_VERSION=$(find_tags 25)
if [[ ! $CL_MINER_VERSION ]]; then
  echo "try to find the release in last 50"
  CL_MINER_VERSION=$(find_tags 50)
fi
if [[ ! $CL_MINER_VERSION ]]; then
  echo "try to find the release in last 100"
  CL_MINER_VERSION=$(find_tags 100)
fi

running_image=$(docker container inspect -f '{{.Config.Image}}' miner | awk -F: '{print $2}')

if [ -n "$LOGDIR" ];
then
        LOGMOUNT="--mount type=bind,source=$LOGDIR,target=/var/data/log"
fi

getLatestMiner() {
        echo -e "\e[1;33m Retrieving latest miner  \e[0m \n"

        if ! docker pull quay.io/team-helium/miner:"${CL_MINER_VERSION}" | grep "Status: Downloaded newer image"; then
                echo -e "\e[1;31m Not able to pull latest image... \e[0m \n"
                exit 1
        fi
}

deleteOldImages() {
        echo -e "\e[1;31m Deleting old images  \e[0m \n"
        docker stop miner && docker rm miner

        for image in $(docker images -q quay.io/team-helium/miner); do
                docker image rm "$image" -f
        done
}

runContainer() {
        echo -e "\e[1;34m Running Miner ....  \e[0m \n"

        docker run -d --restart always --init \
        --ulimit nofile=524288:524288 \
        --env REGION_OVERRIDE="$REGION" \
        --publish "$GWPORT":"$GWPORT"/udp \
        --publish "$MINERPORT":"$MINERPORT"/tcp \
        --name "$MINER" $LOGMOUNT \
        --mount type=bind,source="$DATADIR",target=/var/data \
        --device /dev/i2c-1 \
        --net host \
        --privileged \
        -v /var/run/dbus:/var/run/dbus \
        --env DBUS_SYSTEM_BUS_ADDRESS=unix:path=/var/run/dbus/system_bus_socket \
        --mount type=bind,source=/etc/lsb_release,target=/etc/lsb_release \
        --mount type=bind,source=/home/pi/docker_config/docker.config,target=/config/sys.config \
        quay.io/team-helium/miner:"${CL_MINER_VERSION}"

        echo -e "\e[1;32m MINER up and running!  \e[0m \n"
}

lsb_rel() {
        echo -e "\e[1;34m Updating LSB_RELEASE ....  \e[0m \n"
        >  /etc/lsb_release
        echo 'DISTRIB_ID=raspbian' >> /etc/lsb_release
        echo 'DISTRIB_RELEASE="'$CL_MINER_VERSION'"' >> /etc/lsb_release
        echo 'DISTRIB_CODENAME=bionic' >> /etc/lsb_release
        echo 'DISTRIB_DESCRIPTION="'$CL_MINER_VERSION'"' >> /etc/lsb_release
}

cronUpdater() {
        echo -e "\e[1;34m Updating CRON ....  \e[0m \n"
        if sudo crontab -l | grep -q '/home/pi/gateway_addons/miner_updater.sh'; then
                sudo crontab -l | grep -v '/home/pi/gateway_addons/miner_updater.sh'  | sudo crontab -
        fi
        sudo crontab -l | { cat; echo "0 * * * * /home/pi/gateway_addons/miner_updater.sh"; } | sudo crontab -
}

if [[ ${running_image} == $CL_MINER_VERSION ]]; then
        echo -e "\e[1;32m Miner is already on the latest version. \e[0m \n"
        cronUpdater

else
        echo -e "\e[1;31m Miner needs update or is missing... \e[0m \n"
        deleteOldImages
        getLatestMiner
        lsb_rel
        cronUpdater
        runContainer
fi

exit 0
