Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "New-BarracudaWAFService" {

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
    "name": "name",
    "port": 80,
    "dps-enabled": "No",
    "type": "HTTP",
    "azure-ip-select": "Enter IP Address",
    "linked-service-name": "string"
}         
"@          | ConvertFrom-Json

            $inputObject | New-BarracudaWAFService

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq '/restapi/v3/services' -and $Method -eq 'Post' -and $PostData.Name -eq 'name' -and $PostData.'ip-address' -eq 'ipaddress' } -Times 1
        }

        It "should throw an exception when no name is given" {

            {New-BarracudaWAFService -IpAddress '10.0.0.5' -Name '' -AzureIpSelect 'Enter IP Address'} | Should Throw

        }

        It "should throw an exception when no ip address is given" {
            
            {New-BarracudaWAFService -IpAddress '' -Name 'http' -AzureIpSelect 'Enter IP Address'} | Should Throw

        }

        It "should throw an exception when no azure ip address is given" {
            
            {New-BarracudaWAFService -IpAddress '10.0.0.5' -Name 'http' -AzureIpSelect ''} | Should Throw

        }
    }
}
