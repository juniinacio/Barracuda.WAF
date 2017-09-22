Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Invoke-BarracudaWAFApi" {
        BeforeEach {
            $Script:BWAF_URI = "https://waf1.com"
        }

        It "should generate the correct endpoint" {
            Mock Invoke-RestMethod {}

            Invoke-BarracudaWAFApi -Path "/restapi/v1/login"

            Assert-MockCalled Invoke-RestMethod -ParameterFilter { $Uri -eq "https://waf1.com/restapi/v1/login" }
        }

        It "should include the request body" {
            Mock Invoke-RestMethod {}
            
            $postData = @{
                username="admin"
                password="admin"
            }

            Invoke-BarracudaWAFApi -Path "restapi/v1/login" -PostData $postData -Method Post

            $jsonData = $postData | ConvertTo-Json -Depth 4

            Assert-MockCalled Invoke-RestMethod -ParameterFilter { $Body -eq $jsonData -and $Uri -eq "https://waf1.com/restapi/v1/login"}
        }

        It "should include the authorization header" {
            Mock Invoke-RestMethod {}

            $Script:BWAF_TOKEN = [PSCustomObject]@{
                token = "eyJldCI6IjEzODAyMzE3NTciLCJwYXNzd29yZCI6ImY3NzY2ZTFmNTgwMzgyNmE1YTAzZWZlMzcy\nYzgzOTMyIiwidXNlciI6ImFkbWluIn0="
            }

            Invoke-BarracudaWAFApi -Path "restapi/v1/vsites"

            Assert-MockCalled Invoke-RestMethod -ParameterFilter { $Uri -eq "https://waf1.com/restapi/v1/vsites" -and $Headers.ContainsKey('Authorization')}
        }

        It "should encode the token" {
            Mock Invoke-RestMethod {}

            $Script:BWAF_TOKEN = [PSCustomObject]@{
                token = "eyJldCI6IjEzODAyMzE3NTciLCJwYXNzd29yZCI6ImY3NzY2ZTFmNTgwMzgyNmE1YTAzZWZlMzcy\nYzgzOTMyIiwidXNlciI6ImFkbWluIn0="
            }

            $encodedToken = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes("{0}`r`n:" -f $Script:BWAF_TOKEN.token))

            Invoke-BarracudaWAFApi -Path "restapi/v1/vsites"

            Assert-MockCalled Invoke-RestMethod -ParameterFilter { $Uri -eq "https://waf1.com/restapi/v1/vsites" -and $Headers.ContainsKey('Authorization') -and $Headers.Authorization -eq "Basic $encodedToken"}
        }

        It "should add the query string parameter" {
            Mock Invoke-RestMethod {}

            $Script:BWAF_TOKEN = [PSCustomObject]@{
                token = "eyJldCI6IjEzODAyMzE3NTciLCJwYXNzd29yZCI6ImY3NzY2ZTFmNTgwMzgyNmE1YTAzZWZlMzcy\nYzgzOTMyIiwidXNlciI6ImFkbWluIn0="
            }
            
            Invoke-BarracudaWAFApi -Path '/restapi/v1/system' -Parameters @{
                parameters = 'cluster_shared_secret'
            }

            Assert-MockCalled Invoke-RestMethod -ParameterFilter { $Uri -eq "https://waf1.com/restapi/v1/system?parameters=cluster_shared_secret" -and $Headers.ContainsKey('Authorization') }
        }
    }
}
