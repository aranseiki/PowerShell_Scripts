Clear-Host

$Path = Read-Host 'Digite o caminho de onde deve ser realizado a pesquisa (Ex.: "C:\Program Files")'
$filter = Read-Host 'O arquivo que você procura tem o que no nome?'
$PathObject = Get-ChildItem -Depth 9999 -Path $Path -Filter *$filter* -File -Force -ErrorAction Ignore | Select FullName

$PathObject = $PathObject -replace '"', ''
$PathObject = $PathObject -replace '@{FullName=', ''
$PathObject = $PathObject -replace '}', ''
$PathObject = $PathObject -replace '\[','`['
$PathObject = $PathObject -replace ']', '`]'

Clear-Host

Write-Output `n 'Arquivos encontrados: ' $PathObject `n

$Export = Read-Host 'Deseja exportar o resultado? (Sim / Não)'
$ExportUpper = $export.ToUpper()
$PathToExport = 'C:\Users\'+$env:USERNAME+'\Desktop'
if ($ExportUpper -eq 'SIM') {
    
    $PathExportFile = $PathToExport, 'export.txt' -join '\'
    if ((Test-Path -Path $PathExportFile) -eq $false) {
        New-Item -Path $PathExportFile -ItemType 'File'
    }

    Clear-Content -Path $PathExportFile
    Add-Content -Path $PathToExport\export.txt -Value $PathObject
    Write-Output 'Resultado exportado para: ' $PathToExport `n

    $OpenFile = Read-Host 'Abrir o arquivo exportado agora? (Sim / Não)'
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
