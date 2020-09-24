$Emailpath = "C:\users\ta85865\Desktop\emails.csv"

$Emails = Import-Csv $Emailpath

ForEach ($user in $Emails) {

    $adUser = Get-ADUser -Filter {mail -eq ($user.mail)} -EA SilentlyContinue
    $csvoutput = @()

    If ($null -eq $adUser.samaccountname) {
        $csvoutput += $adUser.samaccountname
    }
    else { 
        Write-Output "Email Does not exist"
    }   
        $csvoutput | Select-Object samaccountname,@{n='mail';e={$user.mail}} | Export-Csv -Path "A/CSV/Path" -NoTypeInformation
 } 