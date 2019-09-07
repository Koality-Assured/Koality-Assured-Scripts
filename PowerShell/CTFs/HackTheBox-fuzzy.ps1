wsl sudo apt-get install gobuster

wsl gobuster -u http://docker.hackthebox.eu:43468/ -w ./directory-list-2.3-medium.txt -t 50 -x php,txt,html,htm

wsl gobuster -u http://docker.hackthebox.eu:43468/api/ -w ./directory-list-2.3-medium.txt -t 50 -x php,txt,html,htm