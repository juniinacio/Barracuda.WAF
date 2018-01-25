Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Update-BarracudaWAFLocationInformation" {

        It "should accept pipeline input" {
            Mock Invoke-Api {}

            $inputObject = @"
{
    "country": "string",
    "rack": "string",
    "slot": "string"
}
"@          | ConvertFrom-Json

            $inputObject | Update-BarracudaWAFLocationInformation

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/system/location" `
                -and    $Method -eq 'Put' `
                -and    $PostData.country -eq 'string' `
                -and    $PostData.rack -eq 'string' `
                -and    $PostData.slot -eq 'string'
            } -Scope It
        }
    }
}
