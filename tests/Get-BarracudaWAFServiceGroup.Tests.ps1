Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Get-BarracudaWAFServiceGroup" {

        It "should retrieve a collection of service groups" {
            Mock Invoke-Api {}

            Get-BarracudaWAFServiceGroup -VSite 'default'

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/vsites/default/service-groups" -and $Method -eq 'Get' }
        }

        It "should retrieve a single service group" {
            Mock Invoke-Api {}
            
            Get-BarracudaWAFServiceGroup -VSite 'default' -Name 'demo_service'

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/vsites/default/service-groups/demo_service" -and $Method -eq 'Get' }
        }

        It "should accept pipeline input" {
            Mock Invoke-Api {}
            
            "demo_service_gp1", "demo_service_gp2" | Get-BarracudaWAFServiceGroup -VSite 'default'

            Assert-MockCalled Invoke-Api -Times 2
        }
    }
}
