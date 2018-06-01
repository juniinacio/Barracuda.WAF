Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Get-BarracudaWAFSecurityPolicyCloaking" {

        It "should retrieve information of security policy cloaking" {
            Mock Invoke-Api {}

            Get-BarracudaWAFSecurityPolicyCloaking -PolicyName 'default'

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/security-policies/default/cloaking" } -Scope It
        }

        It "should accept pipeline input" {

            'default', 'owa' | Get-BarracudaWAFSecurityPolicyCloaking

            Assert-MockCalled Invoke-Api -Times 2 -Scope It

        }

        It "should support parameters query string parameter" {

            Mock Invoke-Api {}

            $params = @('filter-response-header', 'headers-to-filter', 'return-codes-to-exempt', 'suppress-return-code')
            
            Get-BarracudaWAFSecurityPolicyCloaking -PolicyName 'default' -Parameters $params

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/security-policies/default/cloaking" -and $Parameters.parameters -eq ($params -join ',') } -Scope It
        }
    }
}
