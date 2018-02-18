Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Remove-BarracudaWAFUrlAcl" {

        It "should accept pipeline input" {
            Mock Invoke-Api {}

            'demo' | Remove-BarracudaWAFUrlAcl -WebApplicationName "webApp1"

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/services/webApp1/url-acls/demo" -and $Method -eq 'Delete' }
        }

        It "should throw an exception when no web application name is given" {

            {Remove-BarracudaWAFUrlAcl -WebApplicationName '' -URLACLName 'demo'} | Should Throw

        }

        It "should throw an exception when no name is given" {

            {Remove-BarracudaWAFUrlAcl -WebApplicationName 'default' -URLACLName ''} | Should Throw

        }
    }
}