Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Connect-BarracudaWAFAccount" {
        BeforeAll {
            $Script:BWAF_URI = "https://waf1.com"

            $credentials = New-Object System.Management.Automation.PSCredential ("root", $(ConvertTo-SecureString "R00t" -AsPlainText -Force))
        }

        It "should retrieve a token" {
            Mock Invoke-RestMethod {}

            $data = @{
                username = $credentials.GetNetworkCredential().UserName
                password = $credentials.GetNetworkCredential().Password
            }

            $jsonData = $data | ConvertTo-Json

            Connect-BarracudaWAFAccount -Credential $credentials

            Assert-MockCalled Invoke-RestMethod -ParameterFilter { $Uri -eq "https://waf1.com/restapi/v3/login" -and $Body -eq $jsonData -and $Method -eq 'Post' }
        }

        It "should store the token" {
            Mock Invoke-RestMethod {
                [PSCustomObject]@{
                    token = "eyJldCI6IjEzODAyMzE3NTciLCJwYXNzd29yZCI6ImY3NzY2ZTFmNTgwMzgyNmE1YTAzZWZlMzcy\nYzgzOTMyIiwidXNlciI6ImFkbWluIn0="
                }
            }

            $Script:BWAF_TOKEN = $null

            Connect-BarracudaWAFAccount -Credential $credentials

            $Script:BWAF_TOKEN.token | Should Be "eyJldCI6IjEzODAyMzE3NTciLCJwYXNzd29yZCI6ImY3NzY2ZTFmNTgwMzgyNmE1YTAzZWZlMzcy\nYzgzOTMyIiwidXNlciI6ImFkbWluIn0="
        }
    }
}
