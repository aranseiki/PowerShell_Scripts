Clear-Host

$Path = Read-Host 'Digite o caminho de onde deve ser realizado a pesquisa (Ex.: "C:\Program Files")'
$filter = Read-Host 'O arquivo que você procura tem o que no nome?'
$a = Get-ChildItem -Depth 9999 -Path $Path -Filter *$filter* -File -Force -WarningAction SilentlyContinue | Select FullName

$a = $a -replace '"', ''
$a = $a -replace '@{FullName=', ''
$a = $a -replace '}', ''
$a = $a -replace '\[','`['
$a = $a -replace ']', '`]'

Clear-Host

Write-Output `n 'Arquivos encontrados: ' $a `n

$Export = Read-Host 'Deseja exportar o resultado?'
$ExportUpper = $export.ToUpper()
$PathToExport = 'C:\Users\'+$env:USERNAME+'\Desktop'
if ($ExportUpper -eq 'SIM') {

    Clear-Content -Path $PathToExport\export.txt
    Add-Content -Path $PathToExport\export.txt -Value $a
    Write-Output 'Resultado exportado para: ' $PathToExport `n

    $OpenFile = Read-Host 'Abrir o arquivo exportado agora?'
    $OpenFileUpper = $OpenFile.ToUpper()

}

if ($OpenFileUpper -eq 'SIM') {

    & $PathToExport\export.txt

}

Clear-Host

Write-Output 'Início da busca: ' $Path `n
Write-Output 'Foi procurado por: ' $filter `n
Write-Output 'Exportar resultado: ' $Export `n
if ($ExportUpper -eq 'SIM') {

    Write-Output 'Abrir arquivo exportado: ' $OpenFile `n

}
