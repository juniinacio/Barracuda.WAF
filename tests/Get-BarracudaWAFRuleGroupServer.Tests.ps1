Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Get-BarracudaWAFRuleGroupServer" {
        BeforeAll {
            $Script:BWAF_URI = "https://waf1.com"

            $Script:BWAF_TOKEN = [PSCustomObject]@{
                token = "eyJldCI6IjEzODAyMzE3NTciLCJwYXNzd29yZCI6ImY3NzY2ZTFmNTgwMzgyNmE1YTAzZWZlMzcy\nYzgzOTMyIiwidXNlciI6ImFkbWluIn0="
            }
        }

        It "should retrieve a collection of rule group servers" {
            Mock Invoke-RestMethod {}

            Get-BarracudaWAFRuleGroupServer -VirtualServiceId 'demo_service' -RuleId 'rule1'

            Assert-MockCalled Invoke-RestMethod -ParameterFilter { $Uri -eq "https://waf1.com/restapi/v1/virtual_services/demo_service/content_rules/rule1/rg_servers" -and $Headers.ContainsKey('Authorization')}
        }

        It "should retrieve a single rule group server" {
            Mock Invoke-RestMethod {}
            
            Get-BarracudaWAFRuleGroupServer -VirtualServiceId 'demo_service' -RuleId 'rule1' -RGServerId 'demo_server'

            Assert-MockCalled Invoke-RestMethod -ParameterFilter { $Uri -eq "https://waf1.com/restapi/v1/virtual_services/demo_service/content_rules/rule1/rg_servers/demo_server" -and $Headers.ContainsKey('Authorization')}
        }

        It "should accept pipeline input" {
            Mock Invoke-RestMethod {}
            
            "demo_server1", "demo_server2" | Get-BarracudaWAFRuleGroupServer -VirtualServiceId 'demo_service' -RuleId 'rule1'

            Assert-MockCalled Invoke-RestMethod -Times 2
        }
    }
}
