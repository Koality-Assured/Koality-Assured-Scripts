#Script for handling console inputs, using modern PowerShell practices. Also allows override with pipeline.
Param (
    [Parameter(ValueFromPipeline = $true)]
    [string[]]
    $inputCollection
)

Begin{
    If ($null -eq $inputCollection){
        $inputCollection = @()
    }
    Else {
        $input -eq "complete"
    }
}
Process {
    Do{
        $input = Read-Host "Please input your strings, stop adding by typing 'complete'."
        If ($input -notlike "complete"){
            $inputCollection += $input
        }
    }
    while ($input -notlike "complete")
}
End {
    #output or resulting object could go here.
}