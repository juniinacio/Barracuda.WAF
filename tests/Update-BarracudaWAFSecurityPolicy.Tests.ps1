Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Update-BarracudaWAFSecurityPolicy" {

        It "should accept pipeline input" {
            Mock Invoke-Api {}

            $inputObject = @"
{
    "name": "string"
}
"@          | ConvertFrom-Json

            $inputObject | Update-BarracudaWAFSecurityPolicy -PolicyName 'default'

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/security-policies/default" `
                -and    $Method -eq 'Put' `
                -and    $PostData.name -eq 'string' `
            } -Scope It
        }
    }
}