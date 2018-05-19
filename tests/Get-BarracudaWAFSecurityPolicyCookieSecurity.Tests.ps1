Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Get-BarracudaWAFSecurityPolicyCookieSecurity" {

        It "should retrieve information of security policy request limits" {
            Mock Invoke-Api {}

            Get-BarracudaWAFSecurityPolicyCookieSecurity -PolicyName 'default'

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/security-policies/default/cookie-security" } -Scope It
        }

        It "should accept pipeline input" {

            'default', 'owa' | Get-BarracudaWAFSecurityPolicyCookieSecurity

            Assert-MockCalled Invoke-Api -Times 2 -Scope It

        }

        It "should support parameters query string parameter" {

            Mock Invoke-Api {}

            $params = @('allow-unrecognized-cookies', 'cookie-max-age', 'cookie-replay-protection-type', 'cookies-exempted', 'custom-headers', 'days-allowed', 'http-only', 'secure-cookie', 'tamper-proof-mode')
            
            Get-BarracudaWAFSecurityPolicyCookieSecurity -PolicyName 'default' -Parameters $params

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/security-policies/default/cookie-security" -and $Parameters.parameters -eq ($params -join ',') } -Scope It
        }
    }
}
