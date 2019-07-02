# PowerShell to adding SSL Cert and Restart Service.
# Version 1.0.0
# Author: Taylor D. Marchetta

param($result)

Import-Module RemoteDesktopServices

# Apply certificate
Set-Item -Path RDS:\GatewayServer\SSLCertificate\Thumbprint -Value  $result.ManagedItem.CertificateThumbprintHash -ErrorAction Stop

# Restart TSGateway
Restart-Service TSGateway -Force -ErrorAction Stop