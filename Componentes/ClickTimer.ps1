Clear-Host

$DiretorioRaiz = Split-Path -parent $MyInvocation.MyCommand.Path
$ScriptClickMouseButton = $DiretorioRaiz, 'Click-MouseButton.ps1' -join '\'

. $ScriptClickMouseButton

Write-Host 'Iniciou às ' $(Get-Date -Format HH:mm:ss)


<#
    Opções possíveis de clique:

    MOUSEEVENTF_MOVED,
    MOUSEEVENTF_LEFTDOWN,
    MOUSEEVENTF_LEFTUP,
    MOUSEEVENTF_RIGHTDOWN,
    MOUSEEVENTF_RIGHTUP,
    MOUSEEVENTF_MIDDLEDOWN,
    MOUSEEVENTF_MIDDLEUP,
    MOUSEEVENTF_WHEEL,
    MOUSEEVENTF_XDOWN,
    MOUSEEVENTF_XUP,
    MOUSEEVENTF_ABSOLUTE
#>


while ($true) {
    Click-MouseButton LEFT 10
    Write-Host 'Clicou às ' $(Get-Date -Format HH:mm:ss)
}
