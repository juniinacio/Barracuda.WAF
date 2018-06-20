Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Get-BarracudaWAFClusterNode" {

        It "should retrieve information of cluster nodes" {
            Mock Invoke-Api {}

            $fields = @('ip-address', 'mode', 'serial')

            Get-BarracudaWAFClusterNode

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/cluster/nodes" -and $Parameters.fields -eq $($fields -join ',')} -Scope It
        }

        It "should support parameters query string parameter" {

            Mock Invoke-Api {}

            $fields = @('ip-address', 'mode', 'serial')

            Get-BarracudaWAFClusterNode -Fields $fields

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/cluster/nodes" -and $Parameters.fields -eq ($fields -join ',') } -Scope It
        }
    }
}
