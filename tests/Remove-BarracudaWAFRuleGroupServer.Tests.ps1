Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Remove-BarracudaWAFRuleGroupServer" {

        It "should accept pipeline input" {
            Mock Invoke-Api {}

            "server1" | Remove-BarracudaWAFRuleGroupServer -WebApplicationName 'default' -RuleGroupName 'group1'

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq '/restapi/v3/services/default/content-rules/group1/content-rule-servers/server1' `
                -and    $Method -eq 'Delete'
            } -Times 1
        }

        It "should throw an exception when no web application name is given" {

            {Remove-BarracudaWAFRuleGroupServer -WebApplicationName '' -RuleGroupName 'group1' -WebServerName 'server1'} | Should Throw

        }

        It "should throw an exception when no rule group name is given" {

            {Remove-BarracudaWAFRuleGroupServer -WebApplicationName 'webApp1' -RuleGroupName '' -WebServerName 'server1'} | Should Throw

        }

        It "should throw an exception when no web server name is given" {

            {Remove-BarracudaWAFRuleGroupServer -WebApplicationName 'webApp1' -RuleGroupName 'group1' -WebServerName ''} | Should Throw

        }
    }
}
