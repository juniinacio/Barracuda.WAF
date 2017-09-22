Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Get-BarracudaWAFSecurityPolicy" {
        BeforeAll {
            $Script:BWAF_URI = "https://waf1.com"

            $Script:BWAF_TOKEN = [PSCustomObject]@{
                token = "eyJldCI6IjEzODAyMzE3NTciLCJwYXNzd29yZCI6ImY3NzY2ZTFmNTgwMzgyNmE1YTAzZWZlMzcy\nYzgzOTMyIiwidXNlciI6ImFkbWluIn0="
            }
        }

        It "should retrieve a collection of security policies" {
            Mock Invoke-RestMethod {}

            Get-BarracudaWAFSecurityPolicy

            Assert-MockCalled Invoke-RestMethod -ParameterFilter { $Uri -eq "https://waf1.com/restapi/v1/security_policies" -and $Headers.ContainsKey('Authorization')}
        }

        It "should retrieve a single security policy" {
            Mock Invoke-RestMethod {}
            
            Get-BarracudaWAFSecurityPolicy -PolicyId "new_policy"

            Assert-MockCalled Invoke-RestMethod -ParameterFilter { $Uri -eq "https://waf1.com/restapi/v1/security_policies/new_policy" -and $Headers.ContainsKey('Authorization')}
        }

        It "should accept pipeline input" {
            Mock Invoke-RestMethod {}
            
            "new_policy1", "new_policy2" | Get-BarracudaWAFSecurityPolicy

            Assert-MockCalled Invoke-RestMethod -Times 2
        }
    }
}
