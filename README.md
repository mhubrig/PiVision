Web based interface for controlling the Raspberry Pi Camera, includes motion detection, time lapse, and image and video recording.
Current version 6.4.21
All information on this project can be found here: http://www.raspberrypi.org/forums/viewtopic.php?f=43&t=63276

The wiki page can be found here:

http://elinux.org/RPi-Cam-Web-Interface


Additions:
Installation for OpenCV and config options were setup for the user in the new install script.
Custom config allows for a standardized install.




Install Instructions

sudo apt-get update

sudo apt-get upgrade (ensures clean install for package finding)

sudo raspi-config

then, ensure camera is selected as on for the system under interfacing options

Reboot, then ensure sudo apt-get upgrade runs without new updates, ensures package list is finalized before install

git clone https://github.com/mhubrig/PiVision.git

cd PiVision

sudo chmod +x *.sh *.cfg

./install.sh

Select yes, to start camera now.

Continute install of system packages and requirements.

Approximate Install Time: 1-2 hours.


Telegram Information for Adding Motion Notifiacations

Start by installing the Telegram app on your phone or desktop (this process will create your account – https://telegram.org), and then sign up for a Telegram bot using Botfather with the instructions here: https://core.telegram.org/bots#6-botfather.
 
Make a note of your API Token and bot username (the one that must end in bot)
 
We now need to obtain your bot’s chatid. To do this, enter the bot username in the Telegram search field (either in Contacts or Chats), then select the bot to initiate a chat with it, and then send a message. This process will establish a conversation (or chat) between you and the bot, identified as a chatid.
 
To find the chatid, enter the following URL in a browser (your API token goes after and right next to /bot):


https://api.telegram.org/botReplaceThisWithTheBotFatherToken/getUpdates
 
e.g, if your API is “123456789:jekcjrnekjrhteuncheiucnf”:


https://api.telegram.org/bot123456789:jekcjrnekjrhteuncheiucnf/getUpdates
 
You need the “id” number from the output it produces:


"message":{"message_id":2872,"from":{"id":987654321,
 
In the example above, this would be “987654321”
 
If you only see {“ok”:true,”result”:[]}, it means you haven’t yet sent your bot a message from your account.

sudo mv motion_event.sh configfile.cfg /var/www/html/macros

sudo chmod +x /var/www/html/macros/motion_event.sh

sudo chown www-data:www-data /var/www/html/macros/motion_event.sh

sudo chown www-data:www-data /var/www/html/macros/configfile.cfg

sudo nano /var/www/html/macros/configfile.cfg #and replace tokennurl and chatid with your own.

sudo su - www-data

cd /var/www/html/macros/

./motion_event.sh 1

Telegram is now setup to send notifacations and a picture when movement is detected.







To instead get SMS notifications, sign up for a twillio account https://www.twilio.com/try-twilio

Start a new project, and get a sample Twillio phone number.

Instead of sudo mv motion_event.sh configfile.cfg /var/www/html/macros, 

mv motion_event_twillio.sh configfile.cfg /var/www/html/macros and follow instructions using the motion_event_twillio.sh script instead of just motion_event.sh

You need to note down account sid and auth token, and replace in the file just as with telegram where it shows

account_sid="ACXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

auth_token="your_auth_token"
