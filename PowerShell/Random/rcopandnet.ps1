$Cred = Get-Credential
$HostName = Read-Host -Prompt 'Enter Hostname of destination PC'

Start-Process -Filepath "\\fileshare\IS\sysinternals\PSexec.exe" -ArgumentList "\\$HostName -s winrm.cmd quickconfig -q"
Start-Sleep -Seconds 3
$Session = New-PSSession -ComputerName $HostName -Credential $Cred
$WinVer = Invoke-Command -Session $Session -Scriptblock {(Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").ReleaseId}

Switch ($WinVer){
    1909 {
        $Path = '\\fileshare\IS\dotnet\1909\sources\sxs*'; break
    }
    1903 {
        $Path = '\\fileshare\IS\dotnet\1903\sources\sxs'; break
    }
    1809 {
        $Path = '\\fileshare\shared\IS\dotnet\1809\sources\sxs'; break
    }
    Default {
        Write-Output "Invalid version of Windows Selected! Version was $WinVer.";exit
    }
}

If (Test-Path -Path "\\$HostName\c$\sources\sxs"){
    Remove-Item -Path "\\$HostName\c$\sources" -Recurse
    Write-Output "Folder path already exists. Removing folder 'Sources\sxs' and copying files from Filer. This should take about 20-30 seconds." -ForegroundColor Green
}
Else{
    Write-Output "Folder does not exist, copying files from Filer. This should take about 20-30 seconds." -ForegroundColor Green
}
Copy-Item -Path $Path -Destination "\\$hostname\c$\sources\sxs" -Recurse

Write-Output "Checking to see if .NET 3.5 is Enabled BEFORE we enable it." -ForegroundColor Green
Invoke-Command -Session $Session -Scriptblock {
    Dism.exe /Online /Get-FeatureInfo /FeatureName:NetFX3
}
Write-Output "Enabling .NET 3.5, this process may take up to 30 seconds." -ForegroundColor Green
Invoke-Command -Session $Session -Scriptblock {
    Dism /Online /Enable-Feature /Featurename:NetFX3 /Source:c:\sources\sxs /LimitAccess /quiet
}
Write-Output "Checking to see if .NET 3.5 is Enabled AFTER enabling the feature."-ForegroundColor Green
Invoke-Command -Session $Session -Scriptblock {
    Dism.exe /Online /Get-FeatureInfo /FeatureName:NetFX3
}

Read-Host "Press enter Key to finish"