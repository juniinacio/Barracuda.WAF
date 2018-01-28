Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Remove-BarracudaWAFRequestRewritePolicy" {

        It "should accept pipeline input" {
            Mock Invoke-Api {}

            'rule1' | Remove-BarracudaWAFRequestRewritePolicy -WebApplicationName "default"

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/services/default/http-request-rewrite-rules/rule1" `
                -and    $Method -eq 'Delete'
            } -Scope It
        }

        It "should throw an exception when no web application name is given" {

            {Remove-BarracudaWAFRequestRewritePolicy -WebApplicationName '' -RuleName 'rule1'} | Should Throw

        }

        It "should throw an exception when no rule name is given" {

            {Remove-BarracudaWAFRequestRewritePolicy -WebApplicationName 'default' -RuleName ''} | Should Throw

        }
    }
}
