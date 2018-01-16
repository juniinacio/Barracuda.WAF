Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Set-BarracudaWAFLicenseTerms" {
        BeforeEach {
            $Script:BWAF_URI = "https://waf1.com"
        }

        It "should activate the hourly sku" {
            Mock Invoke-WebRequest {}
            Mock Get-LicenseTermsBody -MockWith {
                return @{
                    name_sign = "Juni Inacio"
                    email_sign = "juni.inacio@example.com"
                    company_sign = "Macaw OutSourcing Services"
                    eula_hash_val = "ed4480205f84cde3e6bdce0c987348d1d90de9db"
                }
            }

            Set-BarracudaWAFLicenseTerms -Name "Juni Inacio" -Email "juni.inacio@example.com" -Company "Macaw OutSourcing Services"

            Assert-MockCalled Invoke-WebRequest -ParameterFilter { $Uri -eq "https://waf1.com/" -and $UseBasicParsing -eq $true } -Times 1
            Assert-MockCalled Invoke-WebRequest -ParameterFilter { $Uri -eq "https://waf1.com/" -and $UseBasicParsing -eq $true -and $Body.name_sign -eq "Juni Inacio" -and $Body.email_sign -eq "juni.inacio@example.com" -and $Body.company_sign -eq "Macaw OutSourcing Services" -and $Body.eula_hash_val -eq "ed4480205f84cde3e6bdce0c987348d1d90de9db" } -Times 1
        }

        It "should not require company information" {
            Mock Invoke-WebRequest {}
            Mock Get-LicenseTermsBody -MockWith {
                return @{
                    name_sign = "Juni Inacio"
                    email_sign = "juni.inacio@example.com"
                    company_sign = ""
                    eula_hash_val = "ed4480205f84cde3e6bdce0c987348d1d90de9db"
                }
            }

            Set-BarracudaWAFLicenseTerms -Name "Juni Inacio" -Email "juni.inacio@example.com"

            Assert-MockCalled Invoke-WebRequest -ParameterFilter { $Uri -eq "https://waf1.com/" -and $UseBasicParsing -eq $true } -Times 1
            Assert-MockCalled Invoke-WebRequest -ParameterFilter { $Uri -eq "https://waf1.com/" -and $UseBasicParsing -eq $true -and $Body.name_sign -eq "Juni Inacio" -and $Body.email_sign -eq "juni.inacio@example.com" -and $Body.company_sign -eq "" -and $Body.eula_hash_val -eq "ed4480205f84cde3e6bdce0c987348d1d90de9db" } -Times 1
        }
    }
}
