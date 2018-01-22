Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Remove-BarracudaWAFRuleGroup" {

        It "should accept pipeline input" {
            Mock Invoke-Api {}

            'group1' | Remove-BarracudaWAFRuleGroup -WebApplicationName "webApp1"

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/services/webApp1/content-rules/group1" -and $Method -eq 'Delete' }
        }

        It "should throw an exception when no web application name is given" {

            {Remove-BarracudaWAFRuleGroup -WebApplicationName '' -RuleGroupName 'group1'} | Should Throw

        }

        It "should throw an exception when no name is given" {

            {Remove-BarracudaWAFRuleGroup -WebApplicationName 'default' -RuleGroupName ''} | Should Throw

        }
    }
}
