$corFrenteTexto = 'red'
$corFundo = 'black'
$zoom = 180
$Host.PrivateData.ConsolePaneBackgroundColor = $corFundo
$Host.PrivateData.ConsolePaneForegroundColor = $corFrenteTexto
$Host.PrivateData.Zoom = $zoom

#$Host.PrivateData.Window.Topmost = $true

Clear-Host

$a = Get-Date -Format "dd:mm:yyyy" 
Write-Host $a `n 
$a = Get-Date -Format "HH:mm:ss" 
Write-Host `n 'Horário atual: ' $a

$alarme = Read-Host `n 'Defina um horário para ser avisado quando essa hora chegar ("hh:mm:ss") '
$localSomAlarme = ".\togepi.wav"

$corFundoTexto = $corFundo
$corFundoTextoModificado = 'yellow'

while ( $a ) {

    Clear-Host

    $a = Get-Date -Format "dd:mm:yyyy" 
    Write-Host $a `n 
    $a = Get-Date -Format "HH:mm:ss" 
    Write-Host $a
    

    $aString = $a.ToString()
    if ( $aString -eq $alarme ) {

        Write-Host `n 'Aviso!'
        Write-Host `n 'Chegou o horário solicitado'
        $Host.PrivateData.ConsolePaneTextBackgroundColor = $corFundoTextoModificado
        Write-Host `n $alarme
        $a = [System.Media.SoundPlayer]::new()
        $a.SoundLocation = $localSomAlarme
        $a.Play()
        sleep 4
        $Host.PrivateData.ConsolePaneTextBackgroundColor = $corFundoTexto
        

    } elseif ( $aString -gt $alarme ) {
    
        Write-Host `n 'Horário já informado: ' $alarme
    
    } elseif ( $alarme -gt $aString ) {
    
        Write-Host `n 'Foi solicitado aviso no seguinte horário: ' $alarme

    }

    sleep 1
    
}
