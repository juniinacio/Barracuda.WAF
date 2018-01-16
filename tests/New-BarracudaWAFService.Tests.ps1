Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "New-BarracudaWAFService" {
        BeforeEach {
            $Script:BWAF_URI = "https://waf1.com"

            $FilePath = Join-Path -Path $PSScriptRoot -ChildPath "Files\ImportFiles"
        }

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
    "ip-address": "string",
    "mask": "string",
    "address-version": "IPv4",
    "name": "string",
    "port": 80,
    "dps-enabled": "No",
    "type": "HTTP",
    "azure-ip-select": "string",
    "linked-service-name": "string"
}         
"@          | ConvertFrom-Json

            $inputObject | New-BarracudaWAFService

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq '/restapi/v3/services' -and $Method -eq 'Post' -and $PostData -ne $null } -Times 1
        }

        It "should throw an exception when no name is given" {

            {New-BarracudaWAFService -IpAddress '10.0.0.25' -Name '' -AzureIpSelect '10.0.0.10'} | Should Throw

        }

        It "should throw an exception when no ip address is given" {
            
            {New-BarracudaWAFService -IpAddress '' -Name 'http' -AzureIpSelect '10.0.0.10'} | Should Throw

        }
    }
}
