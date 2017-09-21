Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Get-BarracudaWAFServiceGroup" {
        BeforeAll {
            $Script:BWAF_URI = "https://waf1.com"

            $Script:BWAF_TOKEN = [PSCustomObject]@{
                token = "eyJldCI6IjEzODAyMzE3NTciLCJwYXNzd29yZCI6ImY3NzY2ZTFmNTgwMzgyNmE1YTAzZWZlMzcy\nYzgzOTMyIiwidXNlciI6ImFkbWluIn0="
            }
        }

        It "should retrieve a collection of service groups" {
            Mock Invoke-RestMethod {}

            Get-BarracudaWAFServiceGroup -VsiteId 'default'

            Assert-MockCalled Invoke-RestMethod -ParameterFilter { $Uri -eq "https://waf1.com/restapi/v1/vsites/default/service_groups" -and $Headers.ContainsKey('Authorization')}
        }

        It "should retrieve a single service group" {
            Mock Invoke-RestMethod {}
            
            Get-BarracudaWAFServiceGroup -VsiteId 'default' -ServiceGroupId 'demo_service_gp'

            Assert-MockCalled Invoke-RestMethod -ParameterFilter { $Uri -eq "https://waf1.com/restapi/v1/vsites/default/service_groups/demo_service_gp" -and $Headers.ContainsKey('Authorization')}
        }

        It "should support pipeline input" {
            Mock Invoke-RestMethod {}
            
            "demo_service_gp1", "demo_service_gp2" | Get-BarracudaWAFServiceGroup -VsiteId 'default'

            Assert-MockCalled Invoke-RestMethod -Times 2
        }
    }
}
