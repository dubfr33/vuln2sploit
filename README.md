# vuln2sploit
Script to deploy DVWA with slight modifications. Includes a metasploit auxiliary scanner to brute-force the DVWA login page and a stripped down python script to exploit the command injection vuln in DVWA.

# Installing
1. Download Kali Linux and install it in a VM (https://www.kali.org/downloads/)
2. Login to Kali VM as root and make sure your VM has Internet connectivity
3. Open terminal and run these commands
4. apt-get install git -y (This command installs git)
5. cd /opt (This command changes directories to the opt directory)
6. git clone https://github.com/k0rat/vuln2sploit (This command downloads the vuln2sploit repo to your present working directory)
7. cd vuln2sploit (This command changes directories to the vuln2sploit directory)
8. chmod 755 vmsetup.sh (This command changes the file permissions of vmsetup.sh to make it executable)
9. ./vmsetup.sh (This command executes the vmsetup.sh script)
10. Open up Firefox and browse to http://127.0.0.1/dvwa/setup.php
11. Scroll to the bottom of the page and click the Create/Reset Database button
12. Click the login button or browse to http://127.0.0.1/dvwa/login.php
13. At this point you should see a login page for the DVWA application and setup is complete

