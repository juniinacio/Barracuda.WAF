Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "New-BarracudaWAFCertificate" {

        It "should support uploading trusted server certificates" {
            Mock Invoke-Api {}

            $certPath = Join-Path -Path $PSScriptRoot -ChildPath 'Files\Server01.example.com.crt'

            New-BarracudaWAFCertificate -Name 'Server01' -TrustedServerCertificateFilePath $certPath

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "restapi/v3/certificates" -and $Parameters.upload -eq 'trusted_server' -and $Method -eq 'Post' -and $Headers.'Content-Type' -match 'multipart/form-data; boundary="*"' -and $PostData -match '(?m)^Content-Disposition: form-data; name="name"*' -and $PostData -match '(?m)^Content-Disposition: form-data; name="trusted_server_certificate"; filename="*"*' } -Scope It
        }

        It "should support creating self-signed certificates" {
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

        It "should support uploading CA certificates" {
            Mock Invoke-Api {}
    
            $certPath = Join-Path -Path $PSScriptRoot -ChildPath 'Files\DummyCert_Root_CA.crt'
    
            New-BarracudaWAFCertificate -Name 'DummyCert Root CA' -TrustedCACertificateFilePath $certPath
    
            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "restapi/v3/certificates" -and $Parameters.upload -eq 'trusted' -and $Method -eq 'Post' -and $Headers.'Content-Type' -match 'multipart/form-data; boundary="*"' -and $PostData -match '(?m)^Content-Disposition: form-data; name="name"*' -and $PostData -match '(?m)^Content-Disposition: form-data; name="trusted_certificate"; filename="*"*' } -Scope It
        }

        It "should support uploading pem certificates" {
            Mock Invoke-Api {}
    
            $certPath = Join-Path -Path $PSScriptRoot -ChildPath 'Files\DummyCert_Root_CA.crt'
    
            $params = @{
                Name = 'DummyCert Pem Certificate'
                Type = 'pem'
                KeyType = 'ecdsa'
                SignedCertificateFilePath = $certPath
                AssignAssociatedKey = 'yes'
                KeyFilePath = $certPath
                IntermediaryCertificateFilePath = $certPath
                AllowPrivateKeyExport = 'no'
            }
            New-BarracudaWAFCertificate @params 
    
            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "restapi/v3/certificates" `
                -and    $Parameters.upload -eq 'signed' `
                -and    $Method -eq 'Post' `
                -and    $Headers.'Content-Type' -match '^multipart/form-data; boundary="*"' `
                -and    $PostData -match '(?m)^Content-Disposition: form-data; name="name"' `
                -and    $PostData -match '(?m)^DummyCert Pem Certificate' `
                -and    $PostData -match '(?m)^Content-Disposition: form-data; name="type"' `
                -and    $PostData -match '(?m)^pem' `
                -and    $PostData -match '(?m)^Content-Disposition: form-data; name="key_type"' `
                -and    $PostData -match '(?m)^ecdsa' `
                -and    $PostData -match '(?m)^Content-Disposition: form-data; name="signed_certificate"; filename="DummyCert_Root_CA.crt"' `
                -and    $PostData -match '(?m)^Content-Disposition: form-data; name="assign_associated_key"' `
                -and    $PostData -match '(?m)^yes' `
                -and    $PostData -match '(?m)^Content-Disposition: form-data; name="key"; filename="DummyCert_Root_CA.crt"' `
                -and    $PostData -match '(?m)^Content-Disposition: form-data; name="intermediary_certificate"; filename="DummyCert_Root_CA.crt"' `
                -and    $PostData -match '(?m)^Content-Disposition: form-data; name="allow_private_key_export"' `
                -and    $PostData -match '(?m)^no'
            } -Scope It
        }

        It "should support uploading pkcs12 certificates" {
            Mock Invoke-Api {}
    
            $certPath = Join-Path -Path $PSScriptRoot -ChildPath 'Files\Star.example.com.p12'
    
            $params = @{
                Name = 'DummyCert Pkcs12 Certificate'
                Type = 'pkcs12'
                KeyType = 'rsa'
                SignedCertificateFilePath = $certPath
                AllowPrivateKeyExport = 'no'
                Password = ConvertTo-SecureString -String 'V3ryC0mpl#x' -AsPlainText -Force
            }
            New-BarracudaWAFCertificate @params 
    
            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "restapi/v3/certificates" `
                -and    $Parameters.upload -eq 'signed' `
                -and    $Method -eq 'Post' `
                -and    $Headers.'Content-Type' -match '^multipart/form-data; boundary="*"' `
                -and    $PostData -match '(?m)^Content-Disposition: form-data; name="name"' `
                -and    $PostData -match '(?m)^DummyCert Pkcs12 Certificate' `
                -and    $PostData -match '(?m)^Content-Disposition: form-data; name="type"' `
                -and    $PostData -match '(?m)^pkcs12' `
                -and    $PostData -match '(?m)^Content-Disposition: form-data; name="key_type"' `
                -and    $PostData -match '(?m)rsa' `
                -and    $PostData -match '(?m)^Content-Disposition: form-data; name="signed_certificate"; filename="Star.example.com.p12"' `
                -and    $PostData -match '(?m)^Content-Disposition: form-data; name="allow_private_key_export"' `
                -and    $PostData -match '(?m)^no' `
                -and    $PostData -match '(?m)^Content-Disposition: form-data; name="password"' `
                -and    $PostData -match '(?m)^V3ryC0mpl#x' `
            } -Scope It
        }
    }
}
