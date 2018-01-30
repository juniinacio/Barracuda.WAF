Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Get-BarracudaWAFSystemEnergizeUpdatesInformation" {

        It "should retrieve information of energize updates" {
            Mock Invoke-Api {}

            Get-BarracudaWAFSystemEnergizeUpdatesInformation

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/system/energize-updates" `
                -and    $Method -eq 'Get'
            } -Scope It
        }

        It "should retrieve a specific energize update information parameter" {
            Mock Invoke-Api {}

            $params = @('attack-definitions-auto-update', 'geoip-definitions-auto-update', 'security-definitions-auto-update', 'virus-definitions-auto-update')
            
            Get-BarracudaWAFSystemEnergizeUpdatesInformation -Parameters $params

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/system/energize-updates" `
                -and    $Method -eq 'Get' `
                -and    $Parameters.parameters -eq ($params -join ',')
            } -Scope It
        }
    }
}
