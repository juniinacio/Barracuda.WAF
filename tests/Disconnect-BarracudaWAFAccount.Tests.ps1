Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Disconnect-BarracudaWAFAccount" {
        BeforeEach {
            $Script:BWAF_URI = "https://waf1.com"

            $Script:BWAF_TOKEN = [PSCustomObject]@{
                token = "eyJldCI6IjEzODAyMzE3NTciLCJwYXNzd29yZCI6ImY3NzY2ZTFmNTgwMzgyNmE1YTAzZWZlMzcy\nYzgzOTMyIiwidXNlciI6ImFkbWluIn0="
            }
        }

        It "should call the correct endpoint" {
            Mock Invoke-RestMethod {}

            Disconnect-BarracudaWAFAccount

            Assert-MockCalled Invoke-RestMethod -ParameterFilter { $Uri -eq "https://waf1.com/restapi/v3/logout" -and $Headers.ContainsKey('Authorization') -and $Method -eq 'Delete' }
        }

        It "should remove the token" {
            Mock Invoke-RestMethod {}

            Disconnect-BarracudaWAFAccount

            $Script:BWAF_TOKEN | Should BeNullOrEmpty
        }
    }
}
