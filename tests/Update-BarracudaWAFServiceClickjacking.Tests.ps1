Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Update-BarracudaWAFServiceClickjacking" {

        It "should accept pipeline input" {
            Mock Invoke-Api {}

            $inputObject = @"
{
    "allowed-origin": "string",
    "options": "Same Origin",
    "status": "Off"
}         
"@          | ConvertFrom-Json

            $inputObject | Update-BarracudaWAFServiceClickjacking -WebApplicationName 'demo'

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq '/restapi/v3/services/demo/clickjacking' `
                -and    $Method -eq 'Put' `
            } -Times 1
        }

        It "should throw an exception when no name is given" {

            {Update-BarracudaWAFServiceClickjacking -WebApplicationName '' -Ciphers 'Default'} | Should Throw

        }
    }
}
