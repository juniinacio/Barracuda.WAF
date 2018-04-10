Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Get-BarracudaWAFSecurityPolicy" {

        It "should retrieve a collection of security policies" {
            Mock Invoke-Api {}

            Get-BarracudaWAFSecurityPolicy

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/security-policies" } -Scope It
        }

        It "should retrieve a single security policy" {
            Mock Invoke-Api {}
            
            Get-BarracudaWAFSecurityPolicy -PolicyName 'default'

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/security-policies/default" } -Scope It
        }

        It "should accept pipeline input" {

            'default', 'owa' | Get-BarracudaWAFSecurityPolicy

            Assert-MockCalled Invoke-Api -Times 2 -Scope It

        }

        It "should support parameters query string parameter" {

            Mock Invoke-Api {}

            $params = @('based-on', 'name')
            
            Get-BarracudaWAFSecurityPolicy -PolicyName 'default' -Parameters $params

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/security-policies/default" -and $Parameters.parameters -eq ($params -join ',') } -Scope It
        }

        It "should support groups query string parameter" {
            Mock Invoke-Api {}

            $groups = @('Request Limits', 'URL Normalization', 'Parameter Protection')
            
            Get-BarracudaWAFSecurityPolicy -PolicyName 'default' -Groups $groups

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/security-policies/default" -and $Parameters.groups -eq ($groups -join ',') } -Scope It
        }
    }
}
