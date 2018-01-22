
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath 'Barracuda.WAF/Barracuda.WAF.psd1') -Force

Set-BarracudaWAFApiUrl -Url "http://52.174.105.181:8000"

$secpasswd = ConvertTo-SecureString "1C4BEF4E05923314270F4B66569D2030bUM8WgZmR8ZHzGvR5LKCz!eP&#uehh3r" -AsPlainText -Force
$mycreds = New-Object System.Management.Automation.PSCredential ("admin", $secpasswd)

Connect-BarracudaWAFAccount -Credential ($mycreds) | Out-Null

New-BarracudaWAFCertificate -Name "TestCert00" -Path "D:\_REPOS\GIT\Barracuda.WAF\tests\Files\TrustedServerCertificate.cer" -verbose -debug
