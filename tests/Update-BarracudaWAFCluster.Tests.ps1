Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Update-BarracudaWAFCluster" {

        It "should accept pipeline input" {
            Mock Invoke-Api {}

            $inputObject = @"
{
    "monitor-link": "WAN",
    "failback-mode": "Automatic",
    "heartbeat-frequency": 1,
    "cluster-shared-secret": "string",
    "cluster-name": "string",
    "heartbeat-count-per-interface": 1,
    "transmit-heartbeat-on": "WAN",
    "data-path-failure-action": "Attempt recovery"
}         
"@          | ConvertFrom-Json

            $inputObject | Update-BarracudaWAFCluster

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq '/restapi/v3/cluster' `
                -and    $Method -eq 'Put' `
                -and    $PostData.'monitor-link' -eq 'WAN' `
                -and    $PostData.'failback-mode' -eq 'Automatic' `
                -and    $PostData.'heartbeat-frequency' -eq 1 `
                -and    $PostData.'cluster-shared-secret' -eq 'string' `
                -and    $PostData.'cluster-name' -eq 'string' `
                -and    $PostData.'heartbeat-count-per-interface' -eq 1 `
                -and    $PostData.'transmit-heartbeat-on' -eq 'WAN' `
                -and    $PostData.'data-path-failure-action' -eq 'Attempt recovery' `
            } -Times 1
        }

        It "should throw an exception when no cluster name is given" {

            {Update-BarracudaWAFCluster -ClusterName ''} | Should Throw

        }
    }
}
