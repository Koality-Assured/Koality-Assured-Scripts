function GetStringBetweenTwoStrings($firstString, $secondString, $string){
    #Get content from file
    $file = $string
    #Regex pattern to compare two strings
    $pattern = "$firstString(.*?)$secondString"
    #Perform the opperation
    $result = [regex]::Match($file,$pattern).Groups[1].Value
    #Return result
    return $result
}
$ProgressPreference = "SilentlyContinue"
#$m = new-object -TypeName System.Security.Cryptography.MD5CryptoServiceProvider
#$u = new-object -TypeName System.Text.UTF8Encoding

Measure-Command{
$c = Invoke-WebRequest -Uri http://docker.hackthebox.eu:32813 -SessionVariable s
#$c2 = $c.ParsedHtml.getElementsByTagName('h3')
$h2 = GetStringBetweenTwoStrings -firstString "<h3 align='center'>" -secondString "</h3>" -string $c.Content

$h2 = [System.BitConverter]::ToString($m.ComputeHash($u.GetBytes($c))) -replace '-',''
$r= Invoke-WebRequest -Uri http://docker.hackthebox.eu:32813 -Method Post -Body @{hash=$h2} -WebSession $s
}

$r.Content
