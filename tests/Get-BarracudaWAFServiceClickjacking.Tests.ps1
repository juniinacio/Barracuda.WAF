Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Get-BarracudaWAFServiceClickjacking" {

        It "should retrieve information of clickjacking" {
            Mock Invoke-Api {}

            Get-BarracudaWAFServiceClickjacking -WebApplicationName 'default'

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/services/default/clickjacking" }
        }

        It "should accept pipeline input" {
            Mock Invoke-Api {}
            
            "demo_service1", "demo_service2" | Get-BarracudaWAFServiceClickjacking

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/services/demo_service1/clickjacking" }
            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/services/demo_service2/clickjacking" }
        }

        It "should support parameters query string parameter" {

            Mock Invoke-Api {}

            $params = @('allowed-origin', 'options', 'status')
            
            Get-BarracudaWAFServiceClickjacking -WebApplicationName 'default' -Parameters $params

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/services/default/clickjacking" -and $Parameters.parameters -eq ($params -join ',') } -Scope It
        }
    }
}
