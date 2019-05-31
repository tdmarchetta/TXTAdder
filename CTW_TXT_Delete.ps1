###### PowerShell to adding TXT record with Certify The Web.
###### Version 1.0.0
###### Author: Taylor D. Marchetta
###### Huge thanks to James Crissman

###### String(s) from the BAT file.
param (
    [string]$zone,  #Domain Name
    [string]$id,    #Let's Encrypt nodeName
    [string]$value  #HashValue for Let's Encrypt
    )

###### Gets the API Key from the file.
$APIKey = Get-Content -Path 'C:\TXTAdder\DynuAPIKey.txt'

###### GET Request to Dynu.com - This will get the ID of the domain.
$getdomaindata = Invoke-RestMethod -Method GET -Uri ‘https://api.dynu.com/v2/dns/’ -ContentType ‘application/json’ -Headers @{ “Api-Key” = $APIKey }

###### This is looking for the object domain "ID".
$domainid = $getdomaindata.domains.Where({ $_.name -eq "$zone" }).id

###### This is to get the record ID.
$getrecorddata = Invoke-RestMethod -Method GET -Uri "https://api.dynu.com/v2/dns/$($domainid)/record/" -ContentType ‘application/json’ -Headers @{ “Api-Key” = $APIKey }

###### This is looking for object record "ID".
$recordid = $getrecorddata.dnsRecords.Where({ $_.nodeName -eq '_acme-challenge' }).id

###### Loop thorugh all DNS Records where "nodeName" = "_acme-challenge".
foreach ($element in $recordid) {

###### Delete TXT record to Dynu Record.
Invoke-RestMethod -Method DELETE -Uri "https://api.dynu.com/v2/dns/$($domainid)/record/$($element)" -ContentType ‘application/json’ -Headers @{ “Api-Key” = $APIKey }

}