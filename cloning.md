Instructions...
Before you proceed you need to be aware I take no responsibility for mistakes you could do in the process. If you follow instruction steps everything should work ok. If there is any error or issue with any of below steps contact me imediately. 
And remember, opening controllino hotspot voids warranty. Make sure you use official support before anything else. 

Part 1 (obtain basic data needed to create custom image): 
- Load Raspbian OS on SD card and boot up rPi

- Connect monitor/screen to rPi and execute these comamnds in shell. remember to copy outputs for later
LAN MAC adress lookup:
cat /sys/class/net/eth0/address

Wifi MAC adress lookup:
cat /sys/class/net/wlan0/address

rPi serial # lookup:
cat /proc/cpuinfo | grep Serial | cut -d ' ' -f 2

- Send over to me these data including your hotspot helium name

--------------------------------------------
Part 2 (burning the cloned image to SD card): 
- On Windows pc, download image to your harddrive. Make new folder on C: drive and store the image there for easy access

- Boot your pc with live linux. It can be ubuntu or mint or any debian flavor linux 

- Open File Browser and navigate to pc hard drive and location to the image file

- Write down or remember the path to image file. Here is my example of full path in live linux to the image file which sits on pc harddrive...
/media/mint/68F4150CF414DDDE/folder/controllino.img

- Open Terminal and run "sudo su" command to gain root privileges 

- Run "df" command in terminal window and check exact drive name of your SD card. You will see partition list, focus on the one with about 30gb capacity. Here is my example: 
/dev/mmcblk0p2
Drive name in my case is mmcblk0, we don't need partition number

- Run this command to initate image burn process. Be careful to replace path to image file and your SD card drive name in this command: 
dd if=/media/mint/68F4150CF414DDDE/folder/controllino.img of=/dev/mmcblk0 status=progress

- You will see progress of image burning. It should take 10-20mins. Do not interrupt or do anything on pc during this time

- Once the restore is done, shutdown live linux and put SD card to controllino 

- Let hotspot work at least 10mins after first boot 

- Open hotspot dasboard and contact me for password. You can change it once logged in

I have edited multiple files with your hotspot details. Your controllino needs to boot up and work. Image is created from my controllino in July which had 2022.07.14.0 miner and 1.3.7 dashboard. 
