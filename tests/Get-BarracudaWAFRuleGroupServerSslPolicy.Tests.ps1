Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Get-BarracudaWAFRuleGroupServerSslPolicy" {

        It "should retrieve rule group server ssl policy" {
            Mock Invoke-Api {}

            Get-BarracudaWAFRuleGroupServerSslPolicy -WebApplicationName 'default' -RuleGroupName 'group1' -WebServerName 'server1'

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/services/default/content-rules/group1/content-rule-servers/server1/ssl-policy" } -Scope It
        }

        It "should accept pipeline input" {

            'server1', 'server2' | Get-BarracudaWAFRuleGroupServerSslPolicy -WebApplicationName 'default' -RuleGroupName 'group1'

            Assert-MockCalled Invoke-Api -Times 2 -Scope It

        }

        It "should support parameters query string parameter" {

            Mock Invoke-Api {}

            $params = @('client-certificate', 'enable-https', 'enable-sni', 'enable-ssl-3', 'enable-ssl-compatibility-mode', 'enable-tls-1', 'enable-tls-1-1', 'enable-tls-1-2', 'validate-certificate')
            
            Get-BarracudaWAFRuleGroupServerSslPolicy -WebApplicationName 'default' -RuleGroupName 'group1' -WebServerName 'server1' -Parameters $params

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/services/default/content-rules/group1/content-rule-servers/server1/ssl-policy" -and $Parameters.parameters -eq ($params -join ',') } -Scope It
        }
    }
}
