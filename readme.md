## Purpose

The aim of this script is to extend the functionality of the php script that automates the creation of a VM in oracle always free

The php script and how to use it can be found here:

https://github.com/hitrov/oci-arm-host-capacity

This script requires instalation of the previous script:

    1. Sends and email if the PHP script receives a message different than "out of capacity". This implies success or an error.
    2. Adds timestamp to the log file of the php script

The idea is that you do not need to check if the script had success or is failing, you will receive an email

## How to use

Currently the guide only supports linux:

1. Install python 3.9 or superior (if you do not have it installed) and venv (if you do not have it):
`sudo apt update`
`sudo apt install python3.9 python3.9-venv`
2. run `git clone https://github.com/dpuertamartos/php_email_notification.git`
3. Navigate into the project directory, change the path to correct one: `cd path/to/project/php_email_notification`
4. Install a virtual environment with python 3.9 or superior:
`python3 -m venv venv`
5. Activate the virtual environment:
`source venv/bin/activate`
6. Install the required packages from the `requirements.txt` file in your Python virtual environment:
`pip install -r requirements.txt`
7. Create a `.env` file using the template `.env-example`, and fill each variable with your setup.
8. Make the Python script and bash script executable:

`chmod +x path_to_folder/main.py`

`chmod +x path_to_folder/bash_mail.sh`

10. Try executing the email script `/path/to/folder/bash_mail.sh`. If everything worked you should see the log `execution finished, out of capacity`.
This wont send an email as this is the standard execution when the PHP script cannot create the VM.

11. Edit the cron using `crontab -e` (you can use the nano text editor, for example).
Add a line like this to run the script at your desired frequency (e.g., every 5min):

`*/5 * * * * sudo /path_to_folder/bash_mail.sh`

11b. If you want to have the logs of the bash mail script saved (it can be unnecesary), instead create a directory for logs:

`mkdir /path_to_folder/vm_logs`

add this line to cron:

`*/5 * * * * sudo /path_to_folder/bash_mail.sh >> /path_to_folder/vm_logs/cron_log_$(date +\%Y\%m\%d\%H\%M\%S).log 2>&1
`

12. Remove previous cron jobs executing the standalone php script if you have them. This script already executes it.

Note that the "sudo" command in the cron job might require additional setup, such as configuring the sudoers file, to work without a password prompt. 
Consider running the script as a regular user (remove sudo) if you encounter issues with sudo in cron jobs.

Take in consideration that this scripts runs the PHP script under the hood, check that the PHP script is correctly working before trying to install this script