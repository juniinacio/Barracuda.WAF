Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Get-BarracudaWAFRuleGroupServerApplicationLayerHealthCheck" {

        It "should retrieve rule group server ssl policy" {
            Mock Invoke-Api {}

            Get-BarracudaWAFRuleGroupServerApplicationLayerHealthCheck -WebApplicationName 'default' -RuleGroupName 'group1' -WebServerName 'server1'

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/services/default/content-rules/group1/content-rule-servers/server1/application-layer-health-checks" } -Scope It
        }

        It "should accept pipeline input" {

            'server1', 'server2' | Get-BarracudaWAFRuleGroupServerApplicationLayerHealthCheck -WebApplicationName 'default' -RuleGroupName 'group1'

            Assert-MockCalled Invoke-Api -Times 2 -Scope It

        }

        It "should support parameters query string parameter" {

            Mock Invoke-Api {}

            $params = @('additional-headers', 'domain', 'match-content-string', 'method', 'status-code', 'url')
            
            Get-BarracudaWAFRuleGroupServerApplicationLayerHealthCheck -WebApplicationName 'default' -RuleGroupName 'group1' -WebServerName 'server1' -Parameters $params

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/services/default/content-rules/group1/content-rule-servers/server1/application-layer-health-checks" -and $Parameters.parameters -eq ($params -join ',') } -Scope It
        }
    }
}