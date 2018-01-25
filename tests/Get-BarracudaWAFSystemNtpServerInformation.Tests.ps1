Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Get-BarracudaWAFSystemNtpServerInformation" {

        It "should retrieve information of ntp servers" {
            Mock Invoke-Api {}

            Get-BarracudaWAFSystemNtpServerInformation

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/system/ntp-servers" `
                -and    $Method -eq 'Get'
            } -Scope It
        }

        It "should retrieve a specific ntp server information parameter" {
            Mock Invoke-Api {}
            
            Get-BarracudaWAFSystemNtpServerInformation -Parameters 'description'

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/system/ntp-servers" `
                -and    $Method -eq 'Get'
            } -Scope It
        }

        It "should retrieve information of a specific ntp server" {
            Mock Invoke-Api {}

            Get-BarracudaWAFSystemNtpServerInformation -SystemNTPServerName 'server1'

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/system/ntp-servers/server1" `
                -and    $Method -eq 'Get'
            } -Scope It
        }
    }
}
