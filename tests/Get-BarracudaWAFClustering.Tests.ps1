Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Get-BarracudaWAFClustering" {
        BeforeAll {
            $Script:BWAF_URI = "https://waf1.com"

            $Script:BWAF_TOKEN = [PSCustomObject]@{
                token = "eyJldCI6IjEzODAyMzE3NTciLCJwYXNzd29yZCI6ImY3NzY2ZTFmNTgwMzgyNmE1YTAzZWZlMzcy\nYzgzOTMyIiwidXNlciI6ImFkbWluIn0="
            }
        }

        It "should retrieve the cluster shared key" {
            Mock Invoke-RestMethod {}

            Get-BarracudaWAFClustering -ClusterSharedKey

            Assert-MockCalled Invoke-RestMethod -ParameterFilter { $Uri -eq "https://waf1.com/restapi/v1/system?parameters=cluster_shared_secret" -and $Headers.ContainsKey('Authorization')}
        }

        It "should retrieve cluster details from the first node" {
            Mock Invoke-RestMethod {}

            Get-BarracudaWAFClustering

            Assert-MockCalled Invoke-RestMethod -ParameterFilter { $Uri -eq "https://waf1.com/restapi/v1/system" -and $Headers.ContainsKey('Authorization')}
        }

        It "should retrieve details of clustered nodes" {
            Mock Invoke-RestMethod {}

            Get-BarracudaWAFClustering -ConfigurationCluster

            Assert-MockCalled Invoke-RestMethod -ParameterFilter { $Uri -eq "https://waf1.com/restapi/v1/system/configuration_cluster" -and $Headers.ContainsKey('Authorization')}
        }
    }
}
