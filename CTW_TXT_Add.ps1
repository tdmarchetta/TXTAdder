﻿# TXTAdder
# PowerShell To Adding TXT record with Certify the Web
# Version 1.0.5
# Author: Taylor D. Marchetta
# Huge thanks to Kyle Grey.

# String(s) from the BAT file.
param (
    [string]$zone,  #Domain Name
    [string]$id,    #Let's Encrypt nodeName - _acme-challenge.yourdomain.com
    [string]$value  #HashValue from Let's Encrypt
    )
    
    # Force the use of TLS 1.2    
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

    # Check for 'C:\TXTAdder\DynuAPIKey.txt' file.
    if (Test-Path C:\TXTAdder) {

        # Removes "IX HashValue" in wildcards.
        $zoneReplace = $zone.Replace('*.','')

        # Gets the API Key from the Windows Credentail Manager.
        $APIKey = Get-StoredCredential -AsCredentialObject -Target 'DynuAPIKey' | Select-Object -ExpandProperty Password

        # GET Request to Dynu.com - This will get the ID of the domain.
        $getdomaindata = Invoke-RestMethod -Method GET -Uri ‘https://api.dynu.com/v2/dns/’ -ContentType ‘application/json’ -Headers @{ “Api-Key” = $APIKey }

        # This is looking for the object domain "ID".
        $domainid = $getdomaindata.domains.Where({ $_.name -match $zoneReplace }).id

        # Json data for Dynu API.
        $jsonbody = ConvertTo-Json @{

            domainId           = $domainid
            domainName         = $id # _acme-challenge.yourdomain.com
            nodeName           = "_acme-challenge"
            recordType         = "TXT"
            ttl                = "60"
            state              = "true"
            textData           = $value #HashValue from Let's Encrypt
        }

        # POST TXT record to Dynu Record.
        Invoke-RestMethod -Method POST -Uri "https://api.dynu.com/v2/dns/$($domainid)/record" -ContentType ‘application/json’ -Headers @{ “Api-Key” = $APIKey } -Body $jsonbody

    }
    else
    {

        Write-Host "API Key file not found. Please re-run or run 'Setup.ps1' as administrator"
        exit

    }