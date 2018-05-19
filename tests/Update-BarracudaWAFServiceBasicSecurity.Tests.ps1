Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Update-BarracudaWAFServiceBasicSecurity" {

        It "should accept pipeline input" {
            Mock Invoke-Api {}

            $inputObject = @"
{
    "rate-control-status": "Off",
    "rate-control-pool": "string",
    "web-firewall-log-level": "5-Notice",
    "trusted-hosts-group": "string",
    "mode": "Passive",
    "client-ip-addr-header": "string",
    "ignore-case": "Yes",
    "trusted-hosts-action": "Default",
    "web-firewall-policy": "string"
}         
"@          | ConvertFrom-Json

            $inputObject | Update-BarracudaWAFServiceBasicSecurity -WebApplicationName 'demo'

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq '/restapi/v3/services/demo/basic-security' `
                -and    $Method -eq 'Put' `
                -and    $PostData.'rate-control-status' -eq 'Off' `
                -and    $PostData.'rate-control-pool' -eq 'string' `
                -and    $PostData.'web-firewall-log-level' -eq '5-Notice' `
                -and    $PostData.'trusted-hosts-group' -eq 'string' `
                -and    $PostData.mode -eq 'Passive' `
                -and    $PostData.'client-ip-addr-header' -eq 'string' `
                -and    $PostData.'ignore-case' -eq 'Yes' `
                -and    $PostData.'trusted-hosts-action' -eq 'Default' `
                -and    $PostData.'web-firewall-policy' -eq 'string' `
            } -Times 1
        }

        It "should throw an exception when no name is given" {

            {Update-BarracudaWAFServiceBasicSecurity -WebApplicationName '' -Ciphers 'Default'} | Should Throw

        }
    }
}
