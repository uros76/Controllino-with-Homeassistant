Below are instructions for writing the backup cloned image to your controllino hotspot SD card. 

Before you proceed you need to be aware I take no responsibility for mistakes you could do in the process. If you follow instruction steps everything should work ok. Make sure you also test booting your hotspot with spare power supply. If there is any error or issue with any of below steps contact me imediately. 
And remember, opening your controllino hotspot voids warranty. Make sure you use official support before anything else. 

Edit 16.8.22.: I developed a custom shell script that pulls your hotspot data and fills it into necesary files after first bootup from SD clone image. 
Part 1 of this guide is not needed anymore!
There is a chance you will still need to take some aditional steps to get the upswift service working on your hotspot. I will keep updating this guide when I know more from official support. 

Edit 9.2.23.: with one our friends from community I managed to get my hands on latest SD card image with dashboard 1.4.3 and SSH enabled. I edited the necesary files and added my one time run script which prepares individual hotspot. Now we have a new universal image for controllino hotspots. Unfortunately we lost the ability of remote support from controllino due to recent change from upswift to rport service. This means all the software maintenance is on the user now. Miner should keep updating automaticaly. 

--------------------------------------------
PART 1.: Check if your rPi works over temporary SSH access (no need to connect monitor on rPi)
- Get the latest Raspberry Pi OS imager from here https://www.raspberrypi.com/software/
- Choose operating system rPi OS other > rPi OS Lite (32 or 64bit)
- Press on settings gear icon (bottom right) and enable SSH with specify your password. This SSH access will not be used on your controllino, this is just temporary to test your rPi
- Click save on settings page, choose storage SD card and press write. I suggest you use a spare SD card, size does not matter it can be larger or smaller than 32gb
- Once the OS loads on SD card put it to rPi and boot it up
- On windows PC download latest Putty software from here https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html
- Open Putty app and connect to rPi ssh port 22 entering IP adress into host name
- Use user name pi and passowrd you defined above 
- At this stage if you connected to your rPi this means it's working and it's LAN port too. You can proceed to flashing the universal controllino image

If your hotspot rPi failed to load fresh Raspberry OS then you have hardware problem. Either the rPi board or Lora module is faulty in which case this guide cannot help you. THere is no point in procedding to PART 2 until you resolve hardware problem. 

--------------------------------------------
PART 2.: Flashing the universal controllino image to your SD card  
- On windows PC download latest version of Rusuf https://rufus.ie/downloads/. You can use linux and dd command too. Do not use balena etcher! 
- Download universal controllino image to your PC
- Start the flashing with rufus app to your new SD card. It should take 10-20mins. Do not interrupt or do anything on pc during this time
- Once the restore is done, put SD card to your controllino hotspot 
- Turn on your hotspot and let it work 10mins during first boot. THIS IS VERY IMPORTANT, do not open dashboard or do anything with hotspot during this time 
- Open hotspot dashboard and use temporary password `controllino22` for image with 1.3.7 dashboard OR password `controllino@2023` for image with 1.4.3 dashboard. You need to change the password once logged in!
- Check miner version on dashboard. If everything went well on first boot your miner version needs to be the latest
- During first bootup there are multiple files edited with your hotspot details. Your controllino should boot up and work just fine. Image with dasboard 1.3.7 is created from my controllino in August which and the image with 1.4.3 dashboard is created from different controllino from community friend. 
- Image with dashboard 1.4.3 also has SSH service enabled on port 22. You can connect to it same as described in PART 1 but with user `admin` and password `controllino@2023`. Once logged to SSH you need to change the password! You can do that by running command `passwd` and follow the instructions. 

I appreciate any support of my work. If you feel thankful, you can buy me a virtual beer by transfering symbolic HNT amount to my helium wallet: 13zSBXPeCCXxTrq688J1543vsDBvPxeC2xgo3ss45MLFiDNTcgU



