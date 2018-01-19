Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Remove-BarracudaWAFServer" {

        It "should accept pipeline input" {
            Mock Invoke-Api {}

            $inputObject = @"
{
    "name": "server1"
}         
"@          | ConvertFrom-Json

            $inputObject | Remove-BarracudaWAFServer -WebApplicationName 'default'

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq '/restapi/v3/services/default/servers/server1' -and $Method -eq 'Delete' } -Times 1
        }

        It "should delete the service" {
            Mock Invoke-Api {}

            Remove-BarracudaWAFServer -WebApplicationName 'default' -ServerName 'server1'

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq '/restapi/v3/services/default/servers/server1' -and $Method -eq 'Delete' } -Times 1

        }

        It "should throw an exception when no name is given" {

            {Remove-BarracudaWAFServer -WebApplicationName ''} | Should Throw

        }
    }
}
