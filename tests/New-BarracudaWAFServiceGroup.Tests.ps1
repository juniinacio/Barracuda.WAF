Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "New-BarracudaWAFServiceGroup" {

        It "should accept pipeline input" {
            Mock Invoke-Api {}

            $inputObject = @"
{
    "service-group": "string"
}        
"@          | ConvertFrom-Json

            $inputObject | New-BarracudaWAFServiceGroup -VSite 'default'

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/vsites/default/service-groups" -and $Method -eq 'Post' -and $PostData.'service-group' -eq 'string'}
        }

        It "should throw an exception when no vsite is given" {

            {New-BarracudaWAFServiceGroup -VSite '' -Name 'string'} | Should Throw

        }

        It "should throw an exception when no name is given" {

            {New-BarracudaWAFServiceGroup -VSite 'default' -Name ''} | Should Throw

        }
    }
}
