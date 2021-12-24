$hash = @{
"Subscription" = "Microsoft Imagine"; "Resource group" = "GRP_PortifolioSite"; "Region" = "East Asia";
"Web App Name" = "[concat('webApp-', uniqueString(resourceGroup().id))]"; "Location" = "[resourceGroup().location]";
"Sku" = "F1"; "Language" = ".net"; "Repo Url" = "-"
}

$hash | ConvertTo-Json | Set-Content -Path "C:\Users\techa\Desktop\AzureVirtualMachine.json"

$hash = Get-content -Path "C:\Users\techa\Desktop\AzureVirtualMachine.json" | ConvertFrom-Json

Start-Process $env:vscode "C:\Users\techa\Desktop\AzureVirtualMachine.json"
