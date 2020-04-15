$ar = @("Luke", "Leia"), ("Palpatine", "Vader", "Kylo Ren"), ("Solo", "Chewy")
$count = 0

$ar | ForEach-Object {
    $_ | ForEach-Object {
        $count++
        Write-Output "$count : $_"
    }
}