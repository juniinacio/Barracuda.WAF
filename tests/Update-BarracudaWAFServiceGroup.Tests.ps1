Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Update-BarracudaWAFServiceGroup" {

        It "should accept pipeline input" {
            Mock Invoke-Api {}

            $inputObject = @"
{
    "service-group": "string"
}        
"@          | ConvertFrom-Json

            $inputObject | Update-BarracudaWAFServiceGroup -VSite 'default' -ServiceGroup 'group'

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/vsites/default/service-groups/group" -and $Method -eq 'Put' -and $PostData.'service-group' -eq 'string'}
        }

        It "should throw an exception when no vsite is given" {

            {Update-BarracudaWAFServiceGroup -VSite '' -ServiceGroup 'string'} | Should Throw

        }

        It "should throw an exception when no name is given" {

            {Update-BarracudaWAFServiceGroup -VSite 'default' -ServiceGroup '' -NewServiceGroup 'new'} | Should Throw

        }

        It "should throw an exception when no name is given" {

            {Update-BarracudaWAFServiceGroup -VSite 'default' -ServiceGroup 'name' -NewServiceGroup ''} | Should Throw

        }
    }
}
