Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Get-BarracudaWAFVirtualService" {
        BeforeAll {
            $Script:WAF_URI = "https://waf1.com"

            $Script:ACCESS_TOKEN = [PSCustomObject]@{
                token = "eyJldCI6IjEzODAyMzE3NTciLCJwYXNzd29yZCI6ImY3NzY2ZTFmNTgwMzgyNmE1YTAzZWZlMzcy\nYzgzOTMyIiwidXNlciI6ImFkbWluIn0="
            }
        }

        It "should retrieve a collection of virtual services" {
            Mock Invoke-RestMethod {}

            Get-BarracudaWAFVirtualService

            Assert-MockCalled Invoke-RestMethod -ParameterFilter { $Uri -eq "https://waf1.com/restapi/v1/virtual_services" -and $Headers.ContainsKey('Authorization')}
        }

        It "should retrieve a single virtual service" {
            Mock Invoke-RestMethod {}
            
            Get-BarracudaWAFVirtualService -Id "demo_service"

            Assert-MockCalled Invoke-RestMethod -ParameterFilter { $Uri -eq "https://waf1.com/restapi/v1/virtual_services/demo_service" -and $Headers.ContainsKey('Authorization')}
        }

        It "should support pipeline input" {
            Mock Invoke-RestMethod {}
            
            "demo_service1", "demo_service2" | Get-BarracudaWAFVirtualService

            Assert-MockCalled Invoke-RestMethod -Times 2
        }
    }
}
