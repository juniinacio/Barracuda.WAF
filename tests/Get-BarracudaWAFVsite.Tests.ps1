Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Get-BarracudaWAFVsite" {
        BeforeAll {
            $Script:BWAF_URI = "https://waf1.com"

            $Script:BWAF_TOKEN = [PSCustomObject]@{
                token = "eyJldCI6IjEzODAyMzE3NTciLCJwYXNzd29yZCI6ImY3NzY2ZTFmNTgwMzgyNmE1YTAzZWZlMzcy\nYzgzOTMyIiwidXNlciI6ImFkbWluIn0="
            }
        }

        It "should retrieve a collection of vsites" {
            Mock Invoke-RestMethod {}

            Get-BarracudaWAFVsite

            Assert-MockCalled Invoke-RestMethod -ParameterFilter { $Uri -eq "https://waf1.com/restapi/v1/vsites" -and $Headers.ContainsKey('Authorization')}
        }

        It "should retrieve a single vsite" {
            Mock Invoke-RestMethod {}
            
            Get-BarracudaWAFVsite -VsiteId "default"

            Assert-MockCalled Invoke-RestMethod -ParameterFilter { $Uri -eq "https://waf1.com/restapi/v1/vsites/default" -and $Headers.ContainsKey('Authorization')}
        }

        It "should support pipeline input" {
            Mock Invoke-RestMethod {}
            
            "demo_vsite1", "demo_vsite2" | Get-BarracudaWAFVsite

            Assert-MockCalled Invoke-RestMethod -Times 2
        }
    }
}
