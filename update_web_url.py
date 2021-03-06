#!/usr/bin/python3
import os
import sys
import json

os.chdir("/home/daniel/")
os.chdir("daniml3.github.io")
os.system("rm index.html")

with open("/home/daniel/ngroklog.log") as log:
			line=log.readline()
			while line:
				if "ngrok.io" in line:
					line_data=line
				line=log.readline()
data=json.loads(line_data)
ngrok_url=data["url"]

base_html_redirect='<!DOCTYPE html>\n<meta charset="utf-8">\n<title>Redirecting.../</title>\n<meta http-equiv="refresh" content="0; URL={0}/blue">\n<link rel="canonical" href="{0}/blue>'.format(ngrok_url)
print(base_html_redirect, file=open("index.html","wt"))
status=os.popen("git status | grep modified").read()
if status != "":
	os.system("git add index.html")
	os.system("git commit --amend --no-edit")
	os.system("git push --force origin master")
