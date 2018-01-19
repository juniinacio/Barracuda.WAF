Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Get-BarracudaWAFServer" {

        It "should retrieve a collection of servers" {
            Mock Invoke-Api {}

            Get-BarracudaWAFServer -WebApplicationName 'default'

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/services/default/servers" -and $Method -eq 'Get' } -Scope It
        }

        It "should retrieve a single server" {
            Mock Invoke-Api {}
            
            Get-BarracudaWAFServer -WebApplicationName 'default' -ServerName 'demo'

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/services/default/servers/demo" -and $Method -eq 'Get' } -Scope It
        }

        It "should accept pipeline input" {
            Mock Invoke-Api {}
            
            "demo_server1", "demo_server2" | Get-BarracudaWAFServer -WebApplicationName 'default'

            Assert-MockCalled Invoke-Api -Times 2 -Scope It
        }
    }
}
