#!/bin/bash
. /var/www/html/macros/configfile.cfg
  
#If you wish to disable notifications, create a file using "touch /home/pi/nomsgfile.lck"
if [ -f $nomsg ]; then
  logging no true "Message alerting has been disabled, exiting..."
exit
fi
  
#Copy the low res snapshot image from memory to a file
cp /dev/shm/mjpeg/cam.jpg ${webfolder}/cam_new.jpg
  
#On motion detection start (parameter is 1 for on, 0 for off)
fileparams=$1
if [ $fileparams -eq 1 ]
then
  #Send both a single text message and a photo because sometimes the photo message times out if the Telegram servers are busy
   
  logging yes false "Motion detected from ${cameraName}"
  
  
your_number="<your number here>"
curl -X POST -F  ${tokenurl}/sendPhoto \
    -F chat_id=${chatid} \
    -F photo="@${webfolder}/cam_new.jpg" \
    -F caption="Motion detected on ${cameraName}" >> ${curlout} & \
	"Body=Hi there, your new phone number is working." \
    -F "From=${available_number}" -F "To=${your_number}" \
    "https://api.twilio.com/2010-04-01/Accounts/${account_sid}/Messages" \
    -u "${account_sid}:${auth_token}"
  
fi