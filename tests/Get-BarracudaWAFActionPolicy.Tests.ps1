Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Get-BarracudaWAFActionPolicy" {
        BeforeAll {
            $Script:BWAF_URI = "https://waf1.com"

            $Script:BWAF_TOKEN = [PSCustomObject]@{
                token = "eyJldCI6IjEzODAyMzE3NTciLCJwYXNzd29yZCI6ImY3NzY2ZTFmNTgwMzgyNmE1YTAzZWZlMzcy\nYzgzOTMyIiwidXNlciI6ImFkbWluIn0="
            }
        }

        It "should retrieve a collection of attack groups" {
            Mock Invoke-RestMethod {}

            Get-BarracudaWAFActionPolicy -PolicyId 'new_policy'

            Assert-MockCalled Invoke-RestMethod -ParameterFilter { $Uri -eq "https://waf1.com/restapi/v1/security_policies/new_policy/attack_groups" -and $Headers.ContainsKey('Authorization')}
        }

        It "should retrieve a single attack groups" {
            Mock Invoke-RestMethod {}
            
            Get-BarracudaWAFActionPolicy -PolicyId "new_policy" -AttackGroupId 'application-profile-violations'

            Assert-MockCalled Invoke-RestMethod -ParameterFilter { $Uri -eq "https://waf1.com/restapi/v1/security_policies/new_policy/attack_groups/application-profile-violations" -and $Headers.ContainsKey('Authorization')}
        }

        It "should retrieve a collection of attack actions" {
            Mock Invoke-RestMethod {}

            Get-BarracudaWAFActionPolicy -PolicyId 'new_policy' -AttackGroupId 'application-profile-violations' -Action

            Assert-MockCalled Invoke-RestMethod -ParameterFilter { $Uri -eq "https://waf1.com/restapi/v1/security_policies/new_policy/attack_groups/application-profile-violations/actions" -and $Headers.ContainsKey('Authorization')}
        }

        It "should retrieve a single attack action" {
            Mock Invoke-RestMethod {}
            
            Get-BarracudaWAFActionPolicy -PolicyId 'new_policy' -AttackGroupId 'application-profile-violations' -Action -ActionId 'no-url-profile-match'

            Assert-MockCalled Invoke-RestMethod -ParameterFilter { $Uri -eq "https://waf1.com/restapi/v1/security_policies/new_policy/attack_groups/application-profile-violations/actions/no-url-profile-match" -and $Headers.ContainsKey('Authorization')}
        }

        It "should accept pipeline input" {
            Mock Invoke-RestMethod {}
            
            "acl_1", "acl_2" | Get-BarracudaWAFActionPolicy -PolicyId 'new_policy'

            Assert-MockCalled Invoke-RestMethod -Times 2
        }
    }
}
