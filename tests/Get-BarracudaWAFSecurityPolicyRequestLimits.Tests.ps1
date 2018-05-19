Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Get-BarracudaWAFSecurityPolicyRequestLimits" {

        It "should retrieve information of security policy request limits" {
            Mock Invoke-Api {}

            Get-BarracudaWAFSecurityPolicyRequestLimits -PolicyName 'default'

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/security-policies/default/request-limits" } -Scope It
        }

        It "should accept pipeline input" {

            'default', 'owa' | Get-BarracudaWAFSecurityPolicyRequestLimits

            Assert-MockCalled Invoke-Api -Times 2 -Scope It

        }

        It "should support parameters query string parameter" {

            Mock Invoke-Api {}

            $params = @('enable', 'max-cookie-name-length', 'max-cookie-value-length', 'max-header-name-length', 'max-header-value-length', 'max-number-of-cookies', 'max-number-of-headers', 'max-query-length', 'max-request-length', 'max-request-line-length', 'max-url-length')
            
            Get-BarracudaWAFSecurityPolicyRequestLimits -PolicyName 'default' -Parameters $params

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/security-policies/default/request-limits" -and $Parameters.parameters -eq ($params -join ',') } -Scope It
        }
    }
}
