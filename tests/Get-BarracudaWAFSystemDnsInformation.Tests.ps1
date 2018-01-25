Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Get-BarracudaWAFSystemDnsInformation" {

        It "should retrieve information of dns" {
            Mock Invoke-Api {}

            Get-BarracudaWAFSystemDnsInformation

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/system/dns" `
                -and    $Method -eq 'Get'
            } -Scope It
        }

        It "should retrieve a specific dns information parameter" {
            Mock Invoke-Api {}
            
            Get-BarracudaWAFSystemDnsInformation -Parameters 'primary-dns-server'

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/system/dns" `
                -and    $Method -eq 'Get'
            } -Scope It
        }
    }
}
