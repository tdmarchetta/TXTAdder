:: A batch file for https://certifytheweb.com/ > Challenge Type "dns-01" > Create Scipt Path: Put in the correct path to this file.

set zone=%1
set id=%2
set value=%3

powershell.exe -file "C:\TXTAdder\CTW_TXT_Add.ps1" -zone %zone% -id %id% -value %value%