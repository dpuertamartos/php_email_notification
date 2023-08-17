## Purpose

The aim of this script is to extend the functionality of the php script that automates the creation of a VM in oracle always free

The php script and how to use it can be found here:

https://github.com/hitrov/oci-arm-host-capacity

This script requires instalation of the previous script:

    1. Sends and email if the PHP script receives a message different than "out of capacity". This implies success or an error.
    2. Adds timestamp to the log file of the php script

The idea is that you do not need to check if the script had success or is failing, you will receive an email

## How to use

1. install python 3.9 or superior (not explained here, easy to find)
2. run 'git clone https://github.com/dpuertamartos/php_email_notification.git'
3. run 'pip install requirements.txt' in your python enviroment
4. create a .env file with the template .env-example, fill each variable with your setup
4. edit cron using 'crontab -e' (use nano text editor for example)


Example of line added to cron, this will execute this script every 5 minutes:

*/5 * * * * /path/to/python/or/virtual/enviroment/python3 /path/to/this_repo/main.py

Take in consideration that this scripts runs the PHP script under the hood, check that the PHP script is correctly working before trying to install this script