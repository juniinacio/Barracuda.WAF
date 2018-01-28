Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Get-BarracudaWAFRuleGroupServer" {

        It "should retrieve a collection of rule group servers" {
            Mock Invoke-Api {}

            Get-BarracudaWAFRuleGroupServer -WebApplicationName 'webApp1' -RuleGroupName 'group1'

            Assert-MockCalled Invoke-Api -ParameterFilter {
                $Path -eq "/restapi/v3/services/webApp1/content-rules/group1/content-rule-servers"
            }
        }

        It "should retrieve a single rule group server" {
            Mock Invoke-Api {}
            
            Get-BarracudaWAFRuleGroupServer -WebApplicationName "webApp1" -RuleGroupName 'group1' -WebServerName 'server1'

            Assert-MockCalled Invoke-Api -ParameterFilter {
                $Path -eq "/restapi/v3/services/webApp1/content-rules/group1/content-rule-servers/server1"
            } -Scope It
        }

        It "should support groups query string parameter" {
            Mock Invoke-Api {}

            $groups = @('Rule Group Server', 'Connection Pooling', 'Redirect', 'SSL Policy', 'Advanced Configuration', 'In Band Health Checks', 'Application Layer Health Checks', 'Out of Band Health Checks')
            
            Get-BarracudaWAFRuleGroupServer -WebApplicationName "webApp1" -RuleGroupName 'group1' -WebServerName 'server1' -Groups $groups

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/services/webApp1/content-rules/group1/content-rule-servers/server1" `
                -and    $Parameters.groups -eq ($groups -join ',')
            } -Scope It
        }

        It "should support parameters query string parameter" {
            Mock Invoke-Api {}

            $params = @('address-version', 'backup-server', 'comments', 'hostname', 'identifier', 'ip-address', 'name', 'port', 'status', 'weight')
            
            Get-BarracudaWAFRuleGroupServer -WebApplicationName "webApp1" -RuleGroupName 'group1' -WebServerName 'server1' -Parameters $params

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/services/webApp1/content-rules/group1/content-rule-servers/server1" `
                -and    $Parameters.parameters -eq ($params -join ',')
            } -Scope It
        }

        It "should accept pipeline input" {
            Mock Invoke-Api {}
            
            "server1", "server2" | Get-BarracudaWAFRuleGroupServer -WebApplicationName "webApp1" -RuleGroupName 'group1'

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/services/webApp1/content-rules/group1/content-rule-servers/server1" } -Scope It
            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/services/webApp1/content-rules/group1/content-rule-servers/server2" } -Scope It
        }
    }
}
