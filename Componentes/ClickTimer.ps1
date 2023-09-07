Clear-Host

$DiretorioRaiz = Split-Path -parent $MyInvocation.MyCommand.Path
$ScriptClickMouseButton = $DiretorioRaiz, 'Click-MouseButton.ps1' -join '\'

. $ScriptClickMouseButton

Write-Host 'Iniciou às ' $(Get-Date -Format HH:mm:ss)

while ($true) {
    Click-MouseButton LEFT 10
    Write-Host 'Clicou às ' $(Get-Date -Format HH:mm:ss)
}
