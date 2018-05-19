Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Get-BarracudaWAFServiceSslSecurity" {

        It "should retrieve information of ssl security" {
            Mock Invoke-Api {}

            Get-BarracudaWAFServiceSslSecurity -WebApplicationName 'default'

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/services/default/ssl-security" }
        }

        It "should accept pipeline input" {
            Mock Invoke-Api {}
            
            "demo_service1", "demo_service2" | Get-BarracudaWAFServiceSslSecurity

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/services/demo_service1/ssl-security" }
            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/services/demo_service2/ssl-security" }
        }

        It "should support parameters query string parameter" {

            Mock Invoke-Api {}

            $params = @('certificate', 'ciphers', 'domain', 'ecdsa-certificate', 'enable-hsts', 'enable-pfs', 'enable-sni', 'enable-ssl-3', 'enable-strict-sni-check', 'enable-tls-1', 'enable-tls-1-1', 'enable-tls-1-2', 'hsts-max-age', 'include-hsts-sub-domains', 'override-ciphers-ssl3', 'override-ciphers-tls-1', 'override-ciphers-tls-1-1', 'selected-ciphers', 'sni-certificate', 'sni-ecdsa-certificate', 'status')
            
            Get-BarracudaWAFServiceSslSecurity -WebApplicationName 'default' -Parameters $params

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/services/default/ssl-security" -and $Parameters.parameters -eq ($params -join ',') } -Scope It
        }
    }
}
