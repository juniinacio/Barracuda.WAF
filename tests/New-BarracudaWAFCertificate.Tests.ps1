Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "New-BarracudaWAFCertificate" {

        It "should upload information of trusted server certificates" {
            Mock Invoke-Api {}

            $certPath = Join-Path -Path $PSScriptRoot -ChildPath 'Files\Server01.example.com.crt'

            New-BarracudaWAFCertificate -Name 'Server01' -TrustedServerCertificateFilePath $certPath

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "restapi/v3/certificates" -and $Parameters.upload -eq 'trusted_server' -and $Method -eq 'Post' -and $Headers.'Content-Type' -like 'multipart/form-data; boundary="*"' -and $PostData -like '*Content-Disposition: form-data; name="name"*' -and $PostData -like '*Content-Disposition: form-data; name="trusted_server_certificate"; filename="*"*' } -Scope It
        }

        It "should add information of certificates" {
            Mock Invoke-Api {}

            $inputObject = @"
{
    "allow_private_key_export": "yes",
    "city": "string",
    "common_name": "string",
    "country_code": "string",
    "curve_type": "secp256r1",
    "key_size": "1024",
    "key_type": "rsa",
    "name": "string",
    "organization_name": "string",
    "organization_unit": "string",
    "san_certificate": [
    "DNS:<Provide the DNS domain name.>",
    "Email:<Provide the Email.>",
    "URI:<Provide the URI.>",
    "IP:<Provide the IP.>"
    ],
    "state": "string"
}
"@          | ConvertFrom-Json

            $inputObject | New-BarracudaWAFCertificate

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "restapi/v3/certificates" -and $Parameters.Count -eq 0 -and $Headers.Count -eq 0 -and $PostData.name -eq 'string' -and $PostData.allow_private_key_export -eq 'yes' } -Scope It
        }

        It "should upload information of trusted CA certificates" {
            Mock Invoke-Api {}
    
            $certPath = Join-Path -Path $PSScriptRoot -ChildPath 'Files\DummyCert_Root_CA.crt'
    
            New-BarracudaWAFCertificate -Name 'DummyCert Root CA' -TrustedCACertificateFilePath $certPath
    
            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "restapi/v3/certificates" -and $Parameters.upload -eq 'trusted' -and $Method -eq 'Post' -and $Headers.'Content-Type' -like 'multipart/form-data; boundary="*"' -and $PostData -like '*Content-Disposition: form-data; name="name"*' -and $PostData -like '*Content-Disposition: form-data; name="trusted_certificate"; filename="*"*' } -Scope It
        }

        It "should upload information of signed certificates" {
            Mock Invoke-Api {}
    
            $certPath = Join-Path -Path $PSScriptRoot -ChildPath 'Files\DummyCert_Root_CA.crt'
    
            $params = @{
                Name = 'DummyCert Signed Certificate'
                Type = 'pem'
                KeyType = 'ecdsa'
                SignedCertificateFilePath = $certPath
                AssignAssociatedKey = 'no'
                KeyFilePath = $certPath
                IntermediaryCertificateFilePath = $certPath
                AllowPrivateKeyExport = 'no'
                Password = ConvertTo-SecureString -String 'V3ryC0mpl#x' -AsPlainText -Force
            }
            New-BarracudaWAFCertificate @params 
    
            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "restapi/v3/certificates" `
                -and    $Parameters.upload -eq 'signed' `
                -and    $Method -eq 'Post' `
                -and    $Headers.'Content-Type' -like 'multipart/form-data; boundary="*"' `
                -and    $PostData -like '*Content-Disposition: form-data; name="name"*' `
                -and    $PostData -like '*Content-Disposition: form-data; name="type"*' `
                -and    $PostData -like '*Content-Disposition: form-data; name="key_type"*' `
                -and    $PostData -like '*Content-Disposition: form-data; name="signed_certificate"; filename="*"*' `
                -and    $PostData -like '*Content-Disposition: form-data; name="assign_associated_key"*' `
                -and    $PostData -like '*Content-Disposition: form-data; name="key"; filename="*"*' `
                -and    $PostData -like '*Content-Disposition: form-data; name="intermediary_certificate"; filename="*"*' `
                -and    $PostData -like '*Content-Disposition: form-data; name="allow_private_key_export"*' `
                -and    $PostData -like '*Content-Disposition: form-data; name="password"*'
            } -Scope It
        }
    }
}
