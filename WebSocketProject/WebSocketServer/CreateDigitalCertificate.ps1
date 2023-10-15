function Export-MySelfSignedCertificate {
    param (
        [System.Security.Cryptography.X509Certificates.X509Certificate2] $Cert,
        [System.Security.SecureString] $CertPassword,
        [string] $DnsName,
        [string] $ExportPath
    )

    try {
        if ($Cert -ne $null) {
            $CertPath = Export-PfxCertificate -Cert $Cert -FilePath $ExportPath -Password $CertPassword -Force
            Write-Host "Certificado exportado com sucesso para: $($CertPath)"

            return $CertPath
        } else {
            Write-Host "Falha ao gerar o certificado autoassinado."
            return $null
        }
    } catch {
        Write-Host "Erro ao gerar certificado autoassinado: $($_)"
        return $null
    }
}

function New-MySelfSignedCertificate {
    param (
        [string] $DnsName,
        [string] $CertName,
        [DateTime] $notAfter,
        [string] $CertStoreLocation
    )

    try {
        # Gera o certificado com a chave privada associada
        $cert = New-SelfSignedCertificate -DnsName $dnsName -CertStoreLocation $certStoreLocation -FriendlyName $certName -KeyExportPolicy Exportable -KeyProtection None -KeyUsage KeyEncipherment,DataEncipherment,DigitalSignature -Type SSLServerAuthentication

        # $cert = New-SelfSignedCertificate -DnsName $DnsName -CertStoreLocation $CertStoreLocation -FriendlyName $CertName -NotAfter $notAfter
    } catch {
        Write-Host "Erro ao gerar certificado autoassinado: $($_)"
    }

    return $cert
}

function Set-MySelfSignedCertificate {
    param (
        [string] $DnsName,
        [string] $CertName,
        [string] $CertStoreLocation,
        [DateTime] $notAfter,
        [string] $ExportPath,
        [System.Security.SecureString] $CertPassword
    )

    try {
        $Cert = New-MySelfSignedCertificate -DnsName $DnsName -CertName $CertName -CertStoreLocation $CertStoreLocation -notAfter $notAfter

        Export-MySelfSignedCertificate -Cert $Cert -ExportPath $ExportPath -CertPassword $CertPassword -DnsName $DnsName | Out-Null
    } catch {
        Write-Host "Falha ao gerar o certificado autoassinado."
    }
}


$dnsName = "localhost"
$certName = "MySelfSignedCert"
$certPassword = "sua-senha"
$securePassword = ConvertTo-SecureString -String $certPassword `
    -AsPlainText -Force
$exportPath = "C:\dev\WebSocketServer\certificado.pfx"
$certStoreLocation = "cert:\LocalMachine\My"
$notAfter = (Get-Date).AddYears(1)

Set-MySelfSignedCertificate -DnsName $dnsName `
    -CertName $certName `
    -CertPassword $securePassword `
    -ExportPath $exportPath `
    -CertStoreLocation $certStoreLocation `
    -notAfter $notAfter
