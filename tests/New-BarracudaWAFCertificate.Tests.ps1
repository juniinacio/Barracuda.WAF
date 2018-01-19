Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "New-BarracudaWAFCertificate" {
        BeforeEach {
            $CertPath = Join-Path -Path $PSScriptRoot -ChildPath 'Files\TrustedServerCertificate.cer'
        }    

        It "should accept pipeline input" {
            Mock Invoke-Api {}

            New-BarracudaWAFCertificate -Name 'TrustedServerCert' -Path $CertPath

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/certificates" -and $Method -eq 'Post' -and $Headers.'Content-Type' -eq 'multipart/form-data' -and $Parameters.upload -eq 'trusted_server' -and $PostData.name -eq 'TrustedServerCert' -and $PostData.trusted_server_certificate -eq ([Convert]::ToBase64String((Get-Content -Path $CertPath -Encoding Byte))) } -Scope It
        }

        It "should throw an exception when no name is given" {

            {New-BarracudaWAFCertificate -Name '' -Path $CertPath} | Should Throw

        }

        It "should throw an exception when no certificate is given" {

            {New-BarracudaWAFCertificate -Name 'TrustedServerCert' -Path ''} | Should Throw

        }
    }
}
