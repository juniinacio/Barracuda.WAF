Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Remove-BarracudaWAFService" {

        It "should accept pipeline input" {
            Mock Invoke-Api {}

            $inputObject = @"
{
    "name": "string"
}         
"@          | ConvertFrom-Json

            $inputObject | Remove-BarracudaWAFService

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq '/restapi/v3/services/string' -and $Method -eq 'Delete' } -Times 1
        }

        It "should delete the service" {
            Mock Invoke-Api {}

            Remove-BarracudaWAFService -WebApplicationName 'string'

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq '/restapi/v3/services/string' -and $Method -eq 'Delete' } -Times 1

        }

        It "should throw an exception when no name is given" {

            {Remove-BarracudaWAFService -WebApplicationName ''} | Should Throw

        }
    }
}
