Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Update-BarracudaWAFSystemEnergizeUpdatesInformation" {

        It "should accept pipeline input" {
            Mock Invoke-Api {}

            $inputObject = @"
{
    "security-definitions-auto-update": "On",
    "geoip-definitions-auto-update": "On",
    "virus-definitions-auto-update": "On",
    "attack-definitions-auto-update": "On"
}
"@          | ConvertFrom-Json

            $inputObject | Update-BarracudaWAFSystemEnergizeUpdatesInformation

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/system/energize-updates" `
                -and    $Method -eq 'Put' `
                -and    $PostData.'security-definitions-auto-update' -eq 'On' `
                -and    $PostData.'geoip-definitions-auto-update' -eq 'On' `
                -and    $PostData.'virus-definitions-auto-update' -eq 'On' `
                -and    $PostData.'attack-definitions-auto-update' -eq 'On' `
            } -Scope It
        }
    }
}
