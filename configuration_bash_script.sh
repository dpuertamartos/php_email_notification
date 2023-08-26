#!/bin/bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y software-properties-common apt-transport-https
sudo add-apt-repository ppa:ondrej/php
sudo apt update
sudo apt install -y php7.4 php7.4-curl php7.4-cli php7.4-json php7.4-common php7.4-mysql php7.4-zip php7.4-fpm php7.4-mbstring php7.4-xml
php -v
cd ~
curl -sS https://getcomposer.org/installer -o composer-setup.php
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
composer -V
cd ~
git clone https://github.com/hitrov/oci-arm-host-capacity.git
cd oci-arm-host-capacity/
composer install
cp .env.example .env
chmod +x ./index.php
mkdir /home/ubuntu/oci
php ./index.php
sudo apt update
sudo apt install python3.8 python3.8-venv
git clone https://github.com/dpuertamartos/php_email_notification.git
cd php_email_notification
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
cp .env-example .env
chmod +x main.py
chmod +x bash_mail.sh
mkdir /home/ubuntu/Desktop/vm_logs


#fill .env file in oci-arm-host-capacity-> guide: https://github.com/hitrov/oci-arm-host-capacity
#add .pem file from OCI in /home/ubuntu/oci -> guide: https://github.com/hitrov/oci-arm-host-capacity
#fill .env file in php_email_notification-> guide: https://github.com/hitrov/oci-arm-host-capacity
#add this line to cron */5 * * * * sudo /home/ubuntu/php_email_notification/bash_mail.sh >> /home/ubuntu/vm_logs/cron_log_$(date +\%Y\%m\%d\%H\%M\%S).log 2>&1 
