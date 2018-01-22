Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Get-BarracudaWAFRuleGroup" {

        It "should retrieve a collection of rule groups" {
            Mock Invoke-Api {}

            Get-BarracudaWAFRuleGroup -WebApplicationName 'webApp1'

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/services/webApp1/content-rules" }
        }

        It "should retrieve a single rule group" {
            Mock Invoke-Api {}
            
            Get-BarracudaWAFRuleGroup -WebApplicationName "webApp1" -RuleGroupName 'group1'

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/services/webApp1/content-rules/group1" } -Scope It
        }

        It "should support groups query string parameter" {
            Mock Invoke-Api {}

            $groups = @('Logging', 'Caching', 'Load Balancing', 'Compression', 'Rule Group')
            
            Get-BarracudaWAFRuleGroup -WebApplicationName "webApp1" -Groups $groups

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/services/webApp1/content-rules" -and $Parameters.groups -eq ($groups -join ',') } -Scope It
        }

        It "should support parameters query string parameter" {
            Mock Invoke-Api {}

            $params = @('access-log', 'app-id', 'comments', 'extended-match', 'extended-match-sequence', 'host-match', 'mode', 'name', 'status', 'url-match', 'web-firewall-policy')
            
            Get-BarracudaWAFRuleGroup -WebApplicationName "webApp1" -Parameters $params

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/services/webApp1/content-rules" -and $Parameters.parameters -eq ($params -join ',') } -Scope It
        }

        It "should accept pipeline input" {
            Mock Invoke-Api {}
            
            "group1", "group2" | Get-BarracudaWAFRuleGroup -WebApplicationName "webApp1"

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/services/webApp1/content-rules/group1" } -Scope It
            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/services/webApp1/content-rules/group2" } -Scope It
        }
    }
}
