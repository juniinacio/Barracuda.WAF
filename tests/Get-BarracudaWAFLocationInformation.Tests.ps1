Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Get-BarracudaWAFLocationInformation" {

        It "should retrieve information of location" {
            Mock Invoke-Api {}

            Get-BarracudaWAFLocationInformation

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/system/location" `
                -and    $Method -eq 'Get'
            } -Scope It
        }

        It "should retrieve a specific location information parameter" {
            Mock Invoke-Api {}
            
            Get-BarracudaWAFLocationInformation -Parameters 'country'

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/system/location" `
                -and    $Parameters.parameters -eq "country" `
                -and    $Method -eq 'Get'
            } -Scope It
        }
    }
}
