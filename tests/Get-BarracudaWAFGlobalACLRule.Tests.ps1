Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Get-BarracudaWAFGlobalACLRule" {
        BeforeAll {
            $Script:BWAF_URI = "https://waf1.com"

            $Script:BWAF_TOKEN = [PSCustomObject]@{
                token = "eyJldCI6IjEzODAyMzE3NTciLCJwYXNzd29yZCI6ImY3NzY2ZTFmNTgwMzgyNmE1YTAzZWZlMzcy\nYzgzOTMyIiwidXNlciI6ImFkbWluIn0="
            }
        }

        It "should retrieve a collection of data theft elements" {
            Mock Invoke-RestMethod {}

            Get-BarracudaWAFGlobalACLRule -PolicyId 'new_policy'

            Assert-MockCalled Invoke-RestMethod -ParameterFilter { $Uri -eq "https://waf1.com/restapi/v1/security_policies/new_policy/global_acls" -and $Headers.ContainsKey('Authorization')}
        }

        It "should retrieve a single data theft element" {
            Mock Invoke-RestMethod {}
            
            Get-BarracudaWAFGlobalACLRule -PolicyId "new_policy" -GlobalAclId 'acl_1'

            Assert-MockCalled Invoke-RestMethod -ParameterFilter { $Uri -eq "https://waf1.com/restapi/v1/security_policies/new_policy/global_acls/acl_1" -and $Headers.ContainsKey('Authorization')}
        }

        It "should accept pipeline input" {
            Mock Invoke-RestMethod {}
            
            "acl_1", "acl_2" | Get-BarracudaWAFGlobalACLRule -PolicyId "new_policy"

            Assert-MockCalled Invoke-RestMethod -Times 2
        }
    }
}
