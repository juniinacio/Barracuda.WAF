Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Get-BarracudaWAFService" {

        It "should retrieve a collection of virtual services" {
            Mock Invoke-Api {}

            Get-BarracudaWAFService

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/services" }
        }

        It "should retrieve a single virtual service" {
            Mock Invoke-Api {}
            
            Get-BarracudaWAFService -Name "demo_service"

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/services/demo_service" }
        }

        It "should accept pipeline input" {
            Mock Invoke-Api {}
            
            "demo_service1", "demo_service2" | Get-BarracudaWAFService

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/services/demo_service1" }
            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/services/demo_service2" }
        }
    }
}
