#Script for taking in user information and outputting as a specific string out, with logging.
Param (
    [Parameter(ValueFromPipeline,Mandatory)]
    [string]
    $name,
    [Parameter(ValueFromPipeline,Mandatory)]
    [string]
    $username,   
    [Parameter(ValueFromPipeline,Mandatory)]
    [int]
    $age
)

Begin{
    $logPath = "C:\LogPath\log.csv"
    $testPath = Get-Item $logPath
    if ($null -eq $testPath.Name) {
        New-Item $logPath -Force
        Add-Content $logPath -Value "name,age,username" 
    }
}
Process {
    $body = "Your name is $name, you are $age years old, and your username is $username"
    Add-Content $logPath -value "$name,$age,$username"
}
End {
    Write-Output $body
}