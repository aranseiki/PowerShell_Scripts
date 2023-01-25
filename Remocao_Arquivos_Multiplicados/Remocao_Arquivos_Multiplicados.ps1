Clear-Host

Write-Host 'Script iniciado... ' `n

$Path = 'D:\'
Set-Location $Path 
Write-Host 'Caminho raiz a ser verificado:' $Path `n

$Filter = 'DESKTOP-'
Write-Host 'O que estamos procurando no arquivo:' $Filter `n

$PathReport = '.\'
$way = Get-ChildItem -Force -Path $Path -Directory -Depth 999999999 -ErrorAction Ignore | Select FullName
Write-Host 'Pasta destino do arquivo log:' $PathReport `n

Set-Location $PathReport 
$way = $way -replace '"', ''
$way = $way -replace '@{FullName=', ''
$way = $way -replace '\{', '{'
$way = $way -replace '}', ''
$way = $way -replace '\[','`['
$way = $way -replace ']', '`]'
$way > .\report.txt
$ContagemPastasComArquivosDuplicados = 0
$ContagemPastasSemArquivosDuplicados = 0

Set-Location $Path 

Write-Host 'Executando a ação... ' `n

foreach ($item in $way) {
    
    Set-Location $item -ErrorAction Ignore
    
    
    if (Get-ChildItem -Path .\ -File *$Filter* -Recurse -Force -ErrorAction Ignore){
    
        $CurrentLocation = Get-Location
        $CurrentLocation.ToString() 
        Remove-Item -Path .\*$Filter* -Force -Recurse -ErrorAction Ignore
        Write-Host `n 'O arquivo que contem' $Filter 'no nome foi removido' `n `n `n
        Set-Location ..
         $ContagemPastasComArquivosDuplicados++

    } else {
    
        $CurrentLocation = Get-Location
        $CurrentLocation.ToString() 
        Write-Host `n 'Nesta pasta não tem arquivo que contém' $Filter 'no nome. ' `n `n `n
        Set-Location ..
        $ContagemPastasSemArquivosDuplicados++
    }

Set-Location $Path 
     
}

Write-Host 'Ação terminada. ' `n

Add-Content -Path $pathreport\report.txt -Value --------------------------------------------------------------------------

$FinalReportPath = Write-Output "Caminho raiz que foi verificado:" $Path `n
Add-Content -Path $pathreport\report.txt -Value $FinalReportPath

$FinalReportFilter = Write-Output "O que foi procurado no arquivo:" $Filter `n
Add-Content -Path $pathreport\report.txt -Value $FinalReportFilter

$ContagemPastasVerificadas = Get-Content $pathreport\report.txt
$QuantidadePastasVerificadas = Write-Output `n "Quantidade de pastas verificadas:" $ContagemPastasVerificadas.Count `n
$QuantidadePastasVerificadas
Add-Content -Path $pathreport\report.txt -Value $QuantidadePastasVerificadas

$ContagemPastasComArquivosDuplicados = Write-Output `n "Quantidade de pastas com arquivos duplicados:" $ContagemPastasComArquivosDuplicados `n
$ContagemPastasComArquivosDuplicados 
Add-Content -Path $pathreport\report.txt -Value $ContagemPastasComArquivosDuplicados 

$ContagemPastasSemArquivosDuplicados = Write-Output `n "Quantidade de pastas sem arquivos duplicados:" $ContagemPastasSemArquivosDuplicados `n
$ContagemPastasSemArquivosDuplicados
Add-Content -Path $pathreport\report.txt -Value $ContagemPastasSemArquivosDuplicados

