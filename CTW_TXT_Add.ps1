###### PowerShell To Adding TXT record with Certify the Web
###### Version 1.0.0
###### Author: Taylor D. Marchetta
###### Huge thanks to James Crissman

###### String(s) from the BAT file.
param (
    [string]$zone,  #Domain Name
    [string]$id,    #Let's Encrypt nodeName - _acme-challenge.yourdomain.com
    [string]$value  #HashValue for Let's Encrypt
    )

###### Gets the API Key from the file "DynuAPIKey.txt".
$APIKey = Get-Content -Path 'C:\TXTAdder\DynuAPIKey.txt'

###### GET Request to Dynu.com - This will get the ID of the domain.
$getdomaindata = Invoke-RestMethod -Method GET -Uri ‘https://api.dynu.com/v2/dns/’ -ContentType ‘application/json’ -Headers @{ “Api-Key” = $APIKey }

###### This is looking for the object domain "ID".
$domainid = $getdomaindata.domains.Where({ $_.name -eq $zone }).id

###### Json data for Dynu API.
$body1 = ConvertTo-Json @{

    domainId           = $domainid
    domainName         = $id # _acme-challenge.yourdomain.com
    nodeName           = "_acme-challenge"
    recordType         = "TXT"
    ttl                = "60"
    state              = "true"
    textData           = $value
}

###### POST TXT record to Dynu Record.
Invoke-RestMethod -Method POST -Uri "https://api.dynu.com/v2/dns/$($domainid)/record" -ContentType ‘application/json’ -Headers @{ “Api-Key” = $APIKey } -Body $body1
