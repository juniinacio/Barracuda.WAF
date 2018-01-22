Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Get-BarracudaWAFCertificate" {

        It "should retrieve a collection of certificates" {
            Mock Invoke-Api {}

            Get-BarracudaWAFCertificate

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/certificates" } -Scope It
        }

        It "should retrieve a single certificates" {
            Mock Invoke-Api {}
            
            Get-BarracudaWAFCertificate -CertificateName "demo_certificate"

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/certificates/demo_certificate" } -Scope It
        }

        It "should accept pipeline input" {
            Mock Invoke-Api {}
            
            "demo_certificate1", "demo_certificate2" | Get-BarracudaWAFCertificate

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/certificates/demo_certificate1" } -Scope It
            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/certificates/demo_certificate2" } -Scope It
        }

        It "should download certificates" {
            Mock Invoke-Api {}
            
            Get-BarracudaWAFCertificate -CertificateName "demo_certificate" -Download 'csr' -Password (ConvertTo-SecureString -String 'V3ryC0mpl#x' -AsPlainText -Force)

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/certificates/demo_certificate" -and $Parameters.download -eq 'csr' -and $Parameters.password -eq 'V3ryC0mpl#x' } -Scope It
        }
    }
}
