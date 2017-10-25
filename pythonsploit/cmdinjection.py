#!/usr/bin/env python
import argparse
import mechanize
import cookielib

parser = argparse.ArgumentParser(
	epilog='Example: cmdinjection.py admin password 127.0.0.1 id')
parser.add_argument("username", help="DVWA Login Username")
parser.add_argument("password", help="DVWA Login Password")
parser.add_argument("victim_ip", help="IP Address of Victim Machine")
parser.add_argument("cmd", help="CMD to execute")
args = parser.parse_args()
main(args.username,args.password,args.victim_ip,args.cmd)
