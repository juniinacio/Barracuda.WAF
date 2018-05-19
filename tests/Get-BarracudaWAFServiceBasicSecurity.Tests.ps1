Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Get-BarracudaWAFServiceBasicSecurity" {

        It "should retrieve information of basic security" {
            Mock Invoke-Api {}

            Get-BarracudaWAFServiceBasicSecurity -WebApplicationName 'default'

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/services/default/basic-security" }
        }

        It "should accept pipeline input" {
            Mock Invoke-Api {}
            
            "demo_service1", "demo_service2" | Get-BarracudaWAFServiceBasicSecurity

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/services/demo_service1/basic-security" }
            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/services/demo_service2/basic-security" }
        }

        It "should support parameters query string parameter" {

            Mock Invoke-Api {}

            $params = @('client-ip-addr-header', 'ignore-case,mode', 'rate-control-pool', 'rate-control-status', 'trusted-hosts-action', 'trusted-hosts-group', 'web-firewall-log-level', 'web-firewall-policy')
            
            Get-BarracudaWAFServiceBasicSecurity -WebApplicationName 'default' -Parameters $params

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/services/default/basic-security" -and $Parameters.parameters -eq ($params -join ',') } -Scope It
        }
    }
}
