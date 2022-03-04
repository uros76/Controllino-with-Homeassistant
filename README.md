# Controllino with Homeassistant
How to connect Controllino hotspot with your Home Assistant (HA)<br><br>


First, important note. For any of below connections there is **NO SSH access needed with your controllino**! 

This means you do not void hotspot warranty reading data from your controllino. 

Initial requirements: 
- you need to have a working instance of HA. There are many ways to install HA on your devices, check for instructions here: https://www.home-assistant.io/installation/
- on your HA you need to install Home Assistant Community Store (HACS) and File editor add-on
- you need to install Helium integration through HACS<br><br>

<h2> 
Helium wallet and hotspot configuration on HA
</h2>

Since my HA is loaded with various integrations I have my configuration broken into packages. <br>
1. To enable packages feature you need to add these lines into your HA configuration.yaml
```console
homeassistant:
  packages: !include_dir_named packages
```

2. With File editor add-on, you need to create a folder /packages and then a subfolder inside /helium. 
You need to end up with this structure: /config/packages/helium

3. Create a overall.yaml file inside /config/packages/helium folder. Insert the contents from overall.yaml file in this repo. Don't forget to replace THISSHOULDBEYOURxxxADRESS with your actual wallet or hotspot adress. You can add multiple wallets or hotspot adresses. Scan interval under nebra height sensor is set to 300seconds, change if needed but don't exagerate and flood the data pull. 

4. Last step is to create a controllino1.yaml file inside /config/packages/helium folder. Insert the contents from controllino1.yaml file in this repo. Don't forget to replace YOURMINERIP with your actual hotspot local IP adress. Scan intervals are set to 90/120seconds, change if needed but don't exagerate and flood the data pull. You can add multiple hotspot configuration yaml files in same folder. The last section in controllino1.yaml requires SSH acces on your hotspot. If you do not have SSH acces just remove that part from the file. 

Reboot HA and you have working sensors ready to be used on your HA lovelace dasboard. 

View examples of my dashboard connected with helium and hotspot sensors below. All views are avaialble under dashboard folder. 
![ ](/dashboard_example.png)
