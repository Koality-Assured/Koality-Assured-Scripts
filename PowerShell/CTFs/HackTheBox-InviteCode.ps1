#How to find the instructions.
$howto = Invoke-WebRequest -Uri https://www.hackthebox.eu/api/invite/how/to/generate -Method Post 
$howtosplit = $howto.Content.Split(':')
$thekeys1 = $howtosplit[3].Split(',') ; $thekeyb64 = $thekeys1[0].ToString()
$thekeyb64 = $thekeyb64.Replace("`"","")
$thekey = [System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String($thekeyb64))
$thekey

#How to use those instructions.
$genkey = Invoke-WebRequest -Uri https://www.hackthebox.eu/api/invite/generate -Method Post
$genkeysplit = $genkey.Content.Split(':')
$thekeys3 = $genkeysplit[3].Split(',') ; $thekey2b64 = $thekeys3[0].ToString()
$thekey2b64 = $thekey2b64.Replace("`"","")
$therealkey = [System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String($thekey2b64))
$therealkey

