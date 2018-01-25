Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Get-BarracudaWAFSystemInformation" {

        It "should retrieve all system information" {
            Mock Invoke-Api {}

            Get-BarracudaWAFSystemInformation

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/system" -and $Method -eq 'Get' }
        }

        It "should retrieve a specific system information group" {
            Mock Invoke-Api {}
            
            Get-BarracudaWAFSystemInformation -Groups 'Logs Format'

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/system" -and $Method -eq 'Get' -and $Parameters.groups -eq 'Logs Format' }
        }

        It "should retrieve a specific system information parameter" {
            Mock Invoke-Api {}
            
            Get-BarracudaWAFSystemInformation -Parameters 'device-name'

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/system" -and $Method -eq 'Get' -and $Parameters.parameters -eq 'device-name' }
        }
    }
}
