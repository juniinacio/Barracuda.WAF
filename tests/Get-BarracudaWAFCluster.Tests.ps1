Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Get-BarracudaWAFCluster" {

        It "should retrieve information of security policy cloaking" {
            Mock Invoke-Api {}

            Get-BarracudaWAFCluster

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/cluster" } -Scope It
        }

        It "should support parameters query string parameter" {

            Mock Invoke-Api {}

            $groups = @('Cluster', 'Nodes')

            $params = @('cluster-name', 'data-path-failure-action', 'failback-mode', 'heartbeat-count-per-interface', 'heartbeat-frequency', 'monitor-link', 'transmit-heartbeat-on')
            
            Get-BarracudaWAFCluster  -Groups $groups -Parameters $params -Limit 1 -OffSet 1

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/cluster" -and $Parameters.groups -eq ($groups -join ',') -and $Parameters.parameters -eq ($params -join ',') -and $Parameters.limit -eq 1 -and $Parameters.offset -eq 1 } -Scope It
        }
    }
}
