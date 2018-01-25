Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Remove-BarracudaWAFSystemNtpServerInformation" {

        It "should remove information of a specific ntp server" {
            Mock Invoke-Api {}

            Remove-BarracudaWAFSystemNtpServerInformation -SystemNTPServerName 'server1'

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/system/ntp-servers/server1" `
                -and    $Method -eq 'Delete'
            } -Scope It
        }

        It "should accept pipeline input" {
            Mock Invoke-Api {}

            'server1', 'server2' | Remove-BarracudaWAFSystemNtpServerInformation

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/system/ntp-servers/server1" -and $Method -eq 'Delete' } -Scope It
            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/system/ntp-servers/server2" -and $Method -eq 'Delete' } -Scope It
        }

        It "should throw an exception when no name is given" {

            {Remove-BarracudaWAFSystemNtpServerInformation -SystemNTPServerName ''} | Should Throw

        }
    }
}
