Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Update-BarracudaWAFService" {

        It "should accept pipeline input" {
            Mock Invoke-Api {}

            $inputObject = @"
{
    "status": "On",
    "service-id": "string",
    "comments": "string",
    "enable-access-logs": "Yes",
    "session-timeout": 0,
    "app-id": "string",
    "group": "string",
    "vsite": "string",
    "ip-address": "ipaddress",
    "mask": "string",
    "address-version": "IPv4",
    "name": "new",
    "port": 80,
    "dps-enabled": "No",
    "type": "HTTP",
    "azure-ip-select": "string",
    "linked-service-name": "string"
}         
"@          | ConvertFrom-Json

            $inputObject | Update-BarracudaWAFService -WebApplicationName 'name'

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq '/restapi/v3/services/name' -and $Method -eq 'Put' -and $PostData.Name -eq 'new' -and $PostData.'ip-address' -eq 'ipaddress' } -Times 1
        }

        It "should throw an exception when no name is given" {

            {Update-BarracudaWAFService -IpAddress '10.0.0.25' -WebApplicationName '' -AzureIpSelect '10.0.0.10'} | Should Throw

        }

        It "should throw an exception when no ip address is given" {
            
            {Update-BarracudaWAFService -IpAddress '' -WebApplicationName 'http' -AzureIpSelect '10.0.0.10'} | Should Throw

        }
    }
}
