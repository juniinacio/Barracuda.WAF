Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Get-BarracudaWAFContentRule" {
        BeforeAll {
            $Script:BWAF_URI = "https://waf1.com"

            $Script:BWAF_TOKEN = [PSCustomObject]@{
                token = "eyJldCI6IjEzODAyMzE3NTciLCJwYXNzd29yZCI6ImY3NzY2ZTFmNTgwMzgyNmE1YTAzZWZlMzcy\nYzgzOTMyIiwidXNlciI6ImFkbWluIn0="
            }
        }

        It "should retrieve a collection of content rules" {
            Mock Invoke-RestMethod {}

            Get-BarracudaWAFContentRule -VirtualServiceId 'demo_service'

            Assert-MockCalled Invoke-RestMethod -ParameterFilter { $Uri -eq "https://waf1.com/restapi/v1/virtual_services/demo_service/content_rules" -and $Headers.ContainsKey('Authorization')}
        }

        It "should retrieve a single content rule" {
            Mock Invoke-RestMethod {}
            
            Get-BarracudaWAFContentRule -VirtualServiceId 'demo_service' -RuleId 'rule1'

            Assert-MockCalled Invoke-RestMethod -ParameterFilter { $Uri -eq "https://waf1.com/restapi/v1/virtual_services/demo_service/content_rules/rule1" -and $Headers.ContainsKey('Authorization')}
        }

        It "should support pipeline input" {
            Mock Invoke-RestMethod {}
            
            "rule1", "rule2" | Get-BarracudaWAFContentRule -VirtualServiceId 'demo_service'

            Assert-MockCalled Invoke-RestMethod -Times 2
        }
    }
}
