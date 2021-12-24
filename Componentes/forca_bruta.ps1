Clear-Host

$a = Read-Host `n 'Digite um valor numérico inteiro para comparação em força bruta '
$b = 0

while ($a -notlike $b) {

    $b = $b + 1
    Write-Host $b

}

Write-Host `n 'O valor solicitado foi: ' $a
Write-Host `n 'O valor encontrado foi: ' $b `n
