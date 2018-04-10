Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Get-BarracudaWAFBasicSecurity" {

        It "should retrieve a service basic security settings" {
            Mock Invoke-Api {}

            Get-BarracudaWAFBasicSecurity -WebApplicationName 'default'

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/services/default/basic-security" } -Scope It
        }

        It "should accept pipeline input" {

            'default', 'https-dev' | Get-BarracudaWAFBasicSecurity

            Assert-MockCalled Invoke-Api -Times 2 -Scope It

        }

        It "should support parameters query string parameter" {

            Mock Invoke-Api {}

            $params = @('client-ip-addr-header', 'ignore-case,mode', 'rate-control-pool', 'rate-control-status', 'trusted-hosts-action', 'trusted-hosts-group', 'web-firewall-log-level', 'web-firewall-policy')
            
            Get-BarracudaWAFBasicSecurity -WebApplicationName 'default' -Parameters $params

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/services/default/basic-security" -and $Parameters.parameters -eq ($params -join ',') } -Scope It
        }
    }
}
