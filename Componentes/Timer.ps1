$time = Get-Date -Format "HH:mm:ss" 

while ( $time ) {

    Write-Host $time

    $time = Get-Date -Format "HH:mm:ss" 
    Start-Sleep -Seconds 1
    
    Clear-Host

}
