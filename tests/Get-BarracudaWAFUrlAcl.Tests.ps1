Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Get-BarracudaWAFUrlAcl" {

        It "should retrieve a collection of url acls" {
            Mock Invoke-Api {}

            Get-BarracudaWAFUrlAcl -WebApplicationName 'default'

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/services/default/url-acls" } -Scope It
        }

        It "should retrieve a single url acl" {
            Mock Invoke-Api {}
            
            Get-BarracudaWAFUrlAcl -WebApplicationName 'default' -URLACLName 'demo'

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/services/default/url-acls/demo" } -Scope It
        }

        It "should accept pipeline input" {

            'demo1', 'demo2' | Get-BarracudaWAFUrlAcl -WebApplicationName 'default'

            Assert-MockCalled Invoke-Api -Times 2 -Scope It

        }

        It "should support parameters query string parameter" {

            Mock Invoke-Api {}

            $params = @('action', 'comments','deny-response' , 'enable', 'extended-match', 'extended-match-sequence', 'follow-up-action', 'follow-up-action-time', 'host', 'name', 'redirect-url', 'response-page,url')
            
            Get-BarracudaWAFUrlAcl -WebApplicationName 'default' -Parameters $params

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/services/default/url-acls" -and $Parameters.parameters -eq ($params -join ',') } -Scope It
        }
    }
}
