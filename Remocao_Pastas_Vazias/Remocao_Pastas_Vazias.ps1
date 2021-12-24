Clear-Host

$Path = 'D:\OneDrive - Etec Centro Paula Souza'
$PathReport = 'C:\Users\techall\Downloads'
$way = Get-ChildItem -Force -Path $path -Directory -Depth 999999999 | Select FullName
$ContagemPastasVazias = 0
$ContagemPastasJaComConteudo = 0

Set-Location $pathreport 
$way = $way -replace '"', ''
$way = $way -replace '@{FullName=', ''
$way = $way -replace '}', ''
$way = $way -replace '\[','`['
$way = $way -replace ']', '`]'
$way > .\report.txt

Set-Location $Path 

foreach ($item in $way) {
    
    Set-Location $item
    $CurrentPath = ((Get-ChildItem -Path .\ -File -Recurse -Force) -OR (Get-ChildItem -Path .\ -Directory -Recurse -Force))
        
    if ( !$CurrentPath){
        $CurrentPath = Get-Location
        $CurrentPath.ToString()
        Write-Host "Pasta vazia!" `n `n `n
        Set-Location ..
        Remove-Item -Path $CurrentPath -Force
        $ContagemPastasVazias++

    } else {
        $CurrentPath = Get-Location
        $CurrentPath.ToString()
        Write-Host `n 'Pasta já com conteúdo' `n `n `n
        Set-Location ..
        $ContagemPastasJaComConteudo++
    }

Set-Location $Path 
     
}

$ContagemPastasVerificadas = Get-Content $pathreport\report.txt
$QuantidadePastasVerificadas = Write-Output `n "Quantidade de pastas verificadas:" $ContagemPastasVerificadas.Count `n
$QuantidadePastasVerificadas
Add-Content -Path $pathreport\report.txt -Value $QuantidadePastasVerificadas

$QuantidadePastasVazias = Write-Output `n "Quantidade de pastas vazias excluídas:" $ContagemPastasVazias `n
$QuantidadePastasVazias 
Add-Content 'C:\Users\techall\Downloads\report.txt' -Value $QuantidadePastasVazias 

$QuantidadePastasJaComConteudo = Write-Output `n "Quantidade de pastas já com conteúdo:" $ContagemPastasJaComConteudo `n
$QuantidadePastasJaComConteudo
Add-Content -Path $pathreport\report.txt -Value $QuantidadePastasJaComConteudo