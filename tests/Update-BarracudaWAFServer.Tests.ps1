Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Update-BarracudaWAFServer" {

        It "should accept pipeline input" {
            Mock Invoke-Api {}

            $inputObject = @"
{
    "identifier": "IP Address",
    "address-version": "IPv4",
    "status": "In Service",
    "name": "server2",
    "ip-address": "string",
    "hostname": "string",
    "port": 80,
    "comments": "string"
}       
"@          | ConvertFrom-Json

            $inputObject | Update-BarracudaWAFServer -WebApplicationName 'default' -ServerName 'server1'

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/services/default/servers/server1" -and $Method -eq 'Put' -and $PostData.'name' -eq 'server2' } -Scope It
        }

        It "should throw an exception when no web application name is given" {

            {Update-BarracudaWAFServer -WebApplicationName '' -ServerName 'string'} | Should Throw

        }

        It "should throw an exception when no server name is given" {

            {Update-BarracudaWAFServer -WebApplicationName 'default' -ServerName '' -NewName 'new'} | Should Throw

        }
    }
}
