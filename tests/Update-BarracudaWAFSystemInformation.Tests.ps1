Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Update-BarracudaWAFSystemInformation" {

        It "should accept pipeline input" {
            Mock Invoke-Api {}

            $inputObject = @"
{
    "operation-mode": "string",
    "device-name": "string",
    "serial": 0,
    "model": "string",
    "locale": "string",
    "hostname": "string",
    "domain": "string",
    "time-zone": "string",
    "interface-for-system-services": "WAN"
}
"@          | ConvertFrom-Json

            $inputObject | Update-BarracudaWAFSystemInformation

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/system" `
                -and    $Method -eq 'Put' `
                -and    $PostData.'operation-mode' -eq 'string' `
                -and    $PostData.'device-name' -eq 'string' `
                -and    $PostData.serial -eq 0 `
                -and    $PostData.model -eq 'string' `
                -and    $PostData.locale -eq 'string' `
                -and    $PostData.hostname -eq 'string' `
                -and    $PostData.domain -eq 'string' `
                -and    $PostData.'time-zone' -eq 'string' `
                -and    $PostData.'interface-for-system-services' -eq 'WAN'
            } -Scope It
        }
    }
}
