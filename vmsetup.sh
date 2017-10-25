#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

unzipDVWA() {
	echo "Unzipping DVWA-master...."
	unzip DVWA-master.zip 1>/dev/null && echo "Success" || echo "Failed"
}

startRequiredServices() {
	echo "Starting Apache Server...."
	service apache2 start && echo "Success" || echo "Failed"
	echo "Starting MySQL Server...."
	service mysql start && echo "Success" || echo "Failed"
}

copyDVWA() {
	echo "Copying DVWA directory to webroot...."
	cp -R DVWA-master /var/www/html/dvwa && echo "Success" || echo "Failed"
	echo "Modifying DVWA directory permissions...."
	chmod -R 755 /var/www/html/dvwa && echo "Success" || echo "Failed"
	echo "Copying DVWA config file to /var/www/html/dvwa/config/...."
	cp configs/config.inc.php /var/www/html/dvwa/config/ && echo "Success" || echo "Failed"
	echo "Copying DVWA MySQL.php file to /var/www/html/dvwa/dvwa/includes/DBMS/...."
        cp configs/MySQL.php /var/www/html/dvwa/dvwa/includes/DBMS/ && echo "Success" || echo "Failed"
}

vulnerableAccount() {
	echo "Setting vulnerable sudo permissions for www-data account...."
	usermod -aG sudo www-data && echo "Success" || echo "Failed"
	echo "Copying sudoers file to /etc/sudoers...."
	cp configs/sudoers /etc/sudoers && echo "Success" || echo "Failed"
}

configDB() {
	echo "Configuring mySQL for DVWA...."
	mysql -u "root" "-pfoobar" -Bse "create database dvwa;CREATE USER 'user'@'127.0.0.1' IDENTIFIED BY 'p@ssword';grant all on dvwa.* to 'user'@'127.0.0.1';" && echo "Success" || echo "Failed"
	echo "Restarting services so changes may take place...."
	service mysql restart && service apache2 restart && echo "Success" || echo "Failed"
}

copyModules() {
        echo "Copying DVWA login_scanner lib to proper directory...."
        cp metasploitmods/dvwa.rb /usr/share/metasploit-framework/lib/metasploit/framework/login_scanner/
        echo "Creating directory for auxiliary_scanner...."
        mkdir -p ~/.msf4/modules/auxiliary/scanner/http/ && echo "Success" || echo "Failed"
        echo "Copying DVWA auxiliary_scanner module to proper directory...."
        cp metasploitmods/dvwa_login.rb ~/.msf4/modules/auxiliary/scanner/http/ && echo "Success" || ec$
}

echo "Lets get started...."
	unzipDVWA
	startRequiredServices
	copyDVWA
	vulnerableAccount
	configDB
	copyModules
