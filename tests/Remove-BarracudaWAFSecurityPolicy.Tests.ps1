Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Remove-BarracudaWAFSecurityPolicy" {

        It "should accept pipeline input" {
            Mock Invoke-Api {}

            'default' | Remove-BarracudaWAFSecurityPolicy

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/security-policies/default" -and $Method -eq 'Delete' }
        }

        It "should throw an exception when no policy name is given" {

            {Remove-BarracudaWAFSecurityPolicy -PolicyName ''} | Should Throw

        }
    }
}