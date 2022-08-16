Below are instructions for writing the backup cloned image to your controllino hotspot SD card. 

Before you proceed you need to be aware I take no responsibility for mistakes you could do in the process. If you follow instruction steps everything should work ok. Make sure you also test booting your hotspot with spare power supply. If there is any error or issue with any of below steps contact me imediately. 
And remember, opening controllino hotspot voids warranty. Make sure you use official support before anything else. 

Edit 11.8.: before everything below, it is important you obtain your hotspot Upswift Service device_token from Controllino support. Without this token/key you will lose remote support... 

Edit 16.8.: I developed a custom shell script that pulls your hotspot data and fills it into necesary files after first bootup from SD clone image. 
Part 1 of this guide is not needed anymore!

--------------------------------------------
~~PART 1 (obtain basic data needed to create custom image): ~~

~~-Option 1 (over temporary SSH access, no need to connect monitor on rPi)-~~

~~- Get the latest Raspberry Pi OS imager from here https://www.raspberrypi.com/software/~~

~~- Choose operating system rPi OS other > rPi OS Lite (32 or 64bit)~~

~~- Press on settings gear icon (bottom right) and enable SSH with specify your password. This SSH access will not be used on your controllino, this is just temporary to get the necesary data~~

~~- Click save on settigns page, choose storage SD card and press write. I suggest you use a spare SD card, size does not matter it can be larger or smaller than 32gb

~~- Once the OS loads on SD card put it to rPi and boot it up~~

~~- On windows PC download latest Putty software from here https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html 

~~- Open Putty app and connect to rPi ssh port 22 entering IP adress into host name 

~~- Use user name and passowrd you defined above

~~- Execute these comamnds in putty terminal window. Remember to copy the outputs for later

~~LAN MAC adress lookup:
`cat /sys/class/net/eth0/address`

~~Wifi MAC adress lookup:
`cat /sys/class/net/wlan0/address`

~~rPi serial # lookup:
`cat /proc/cpuinfo | grep Serial | cut -d ' ' -f 2`

~~- Type `sudo shutdown now` to safely shutdown rPi 

--------------------------------------------
~~-Option 2 (directly from rPi)-

~~- Get the latest Raspberry Pi OS imager from here https://www.raspberrypi.com/software/

~~- Choose operating system rPi OS other > rPi OS Lite (32 or 64bit)

~~- Choose storage SD card and press write. I suggest you use a spare SD card, size does not matter it can be larger or smaller than 32gb

~~- Once the OS loads on SD card put it to rPi and boot it up

~~- Connect monitor/screen and keyboard to rPi. Optional but advisable > connect LAN cable so you can test the network connectivity. User for terminal is `pi` and default passowrd is `raspberry`

~~- Execute these comamnds in shell. Remember to copy the outputs for later

~~LAN MAC adress lookup:
`cat /sys/class/net/eth0/address`

~~Wifi MAC adress lookup:
`cat /sys/class/net/wlan0/address`

~~rPi serial # lookup:
`cat /proc/cpuinfo | grep Serial | cut -d ' ' -f 2`

~~- Optional step to test connectivity. In terminal window run this command `ping www.google.com`. You should not see errors

~~- Type `sudo shutdown now` to safely shutdown rPi

~~Regardless of option you choose, send me on Discord private message LAN and Wifi MAC adress, rPi serial number and your hotspot helium name. 
Once I have the data I will create the custom image for you. 

--------------------------------------------
--------------------------------------------
PART 2 (burning the custom image to your SD card, this is done after you recieve your image from me).  
Before proceding with image loading make sure you test the rPi if it boots up from Raspbian OS and if network works. 
If you followed above steps and rPi was working with fresh Raspberry OS then you are ok to proceed with below steps. 
If your hotspot rPi failed to load fresh Raspberry OS then you have hardware problem. Either the rPi board or Lora module is faulty in which case this guide cannot help you. 

- On Windows pc, download image to your harddrive. Make a new folder on C: drive and store the image there for easy access

- Boot your pc with live linux loaded on USB stick. I prefer to do it direct from linux since it has native ext4 partition support. There are windows image writing software out there, I just don't use it. 
It can be ubuntu or mint or any debian flavor linux. I use Linux Mint Mate edition from here https://www.linuxmint.com/download.php

- Once you have live linux booted up open File Browser and navigate to your pc hard drive and location to the image file

- Write down or remember the path to image file. Here is my example of full path in live linux to the image file which sits on pc harddrive...
/media/mint/68F4150CF414DDDE/folder/controllino.img

- Open Terminal and run `sudo su` command to gain root privileges 

- Run `df` command in terminal window and check exact drive name of your SD card. You will see partition list, focus on the one with about 30gb capacity. Here is my example: 
/dev/mmcblk0p2
Drive name in my case is mmcblk0, we don't need partition number

- Run this command to initate image burn process. Be careful to replace path to image file and your SD card drive name in this command: 
`dd if=/media/mint/68F4150CF414DDDE/folder/controllino.img of=/dev/mmcblk0 status=progress`

- You will see progress of image burning. It should take 10-20mins. Do not interrupt or do anything on pc during this time

- Once the restore is done, shutdown live linux and put SD card to controllino 

- Turn on your hotspot and let it work 10mins during first boot. This is important, do not open dashboard or do anything with hotspot during this time 

- Open hotspot dashboard and contact me on Discord private message for temporary password. You need to change it once logged in

- Check miner version on dashboard. If everything went well on first boot your miner needs to be the latest. On 12.8. date the latest verion was 2022.08.02.0

There are multiple files edited with your hotspot details. Your controllino should boot up and work just fine. Image is created from my controllino in August which had 2022.08.02.0 miner and 1.3.7 dashboard version. 
