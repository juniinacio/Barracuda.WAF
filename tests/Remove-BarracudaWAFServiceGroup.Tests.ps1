Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Remove-BarracudaWAFServiceGroup" {

        It "should accept pipeline input" {
            Mock Invoke-Api {}

            $inputObject = @"
{
    "service-group": "string"
}        
"@          | ConvertFrom-Json

            $inputObject | Remove-BarracudaWAFServiceGroup -VSite 'default'

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/vsites/default/service-groups/string" -and $Method -eq 'Delete' }
        }

        It "should throw an exception when no vsite is given" {

            {Remove-BarracudaWAFServiceGroup -VSite '' -ServiceGroup 'string'} | Should Throw

        }

        It "should throw an exception when no name is given" {

            {Remove-BarracudaWAFServiceGroup -VSite 'default' -ServiceGroup ''} | Should Throw

        }
    }
}
