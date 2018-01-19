Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "New-BarracudaWAFServer" {

        It "should accept pipeline input" {
            Mock Invoke-Api {}

            $inputObject = @"
{
    "identifier": "IP Address",
    "address-version": "IPv4",
    "status": "In Service",
    "name": "server1",
    "ip-address": "string",
    "hostname": "string",
    "port": 80,
    "comments": "string"
}       
"@          | ConvertFrom-Json

            $inputObject | New-BarracudaWAFServer -WebApplicationName 'default'

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/services/default/servers" -and $Method -eq 'Post' -and $PostData.'name' -eq 'server1' } -Scope It
        }

        It "should throw an exception when no web application name is given" {

            {New-BarracudaWAFServer -WebApplicationName ''} | Should Throw

        }
    }
}
