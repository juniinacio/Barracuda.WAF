Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "New-BarracudaWAFNtpServerInformation" {

        It "should accept pipeline input" {
            Mock Invoke-Api {}

            $inputObject = @"
{
    "name": "string",
    "ip-address": ['192.168.1.1'],
    "description": ['test']
}
"@          | ConvertFrom-Json

            $inputObject | New-BarracudaWAFNtpServerInformation

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/system/ntp-servers" `
                -and    $Method -eq 'Post' `
                -and    $PostData.'name' -eq 'string' `
                -and    $PostData.'ip-address'[0] -eq '192.168.1.1' `
                -and    $PostData.'description'[0] -eq 'test'
            } -Scope It
        }

        It "should throw an exception when no name is given" {

            {New-BarracudaWAFNtpServerInformation -Name '' -IpAddress '192.168.1.1'} | Should Throw

        }

        It "should throw an exception when no ip address is given" {

            {New-BarracudaWAFNtpServerInformation -Name 'timeserver1.ntp.org' -IpAddress ''} | Should Throw

        }
    }
}
