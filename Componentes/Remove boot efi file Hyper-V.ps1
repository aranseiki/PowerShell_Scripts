# RUN THIS IN ADMIN MODE
$VMName = "VM name"
Get-VMFirmware -VMName $VMName |ForEach-Object {
    
    Set-VMFirmware -BootOrder (
        $_.Bootorder | Where-Object {
            $_.BootType -ne 'File'
        }
    ) $_ 

}
