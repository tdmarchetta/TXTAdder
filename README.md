TXTAdder -  PowerShell script for Dynu DNS

Prerequisites

	Download and install Certify The Web 4.1.6.0 or Higher
	PowerShell 3.0 or Higher
	PowerShell files from TXTAdder
	Dynu API Key
	
PowerShell Installation file(s)

	Open "TXTAdder.zip" folder in the download folder

	Right click on "Setup.ps1"

	In the drop down list click on "Run with Administrator”

	Enter the Dynu API Key when prompted

	Open "Certify the Web"

	Click on "New Certificate"

	Delete "New managed Certificate" and enter your domain i.e. "test.dynu.net"

	In Certificate Domains.

	Click on "Select Website (optional):" Default Web Site or the correct IIS Server

	Below is "Add domains to certificate:" enter your domain i.e. "test.dynu.net"

	Go in "Domain Match" enter your domain i.e. "test.dynu.net"

	On "Challenge Type:" change to "dns-01"

	On "DNS Update Method:" change to "(Use Custom Script)"

	Create Script Path: "C:\TXTAdder\CTW_TXT_Add.bat"

	Delete Script Path: "C:\TXTAdder\CTW_TXT_Delete.bat"

	Click "Save"

	Click "Request Certificate”
	
License - MIT License

Copyright 2019 Taylor D. Marchetta

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Citation
	Certify SSL/TLS Certificate Manager - https://certifytheweb.com	
Contact
	taylor@marchetta.me


