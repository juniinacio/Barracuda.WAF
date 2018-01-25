Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "New-BarracudaWAFLocalhostInformation" {

        It "should accept pipeline input" {
            Mock Invoke-Api {}

            $inputObject = @"
{
    "ip-address": "string",
    "hostname": "string"
}
"@          | ConvertFrom-Json

            $inputObject | New-BarracudaWAFLocalhostInformation

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/system/local-hosts" `
                -and    $Method -eq 'Post' `
                -and    $PostData.'ip-address' -eq 'string' `
                -and    $PostData.'hostname' -eq 'string'
            } -Scope It
        }

        It "should throw an exception when no ip address is given" {

            {New-BarracudaWAFService -IpAddress '' -Hostname '' } | Should Throw

        }

        It "should throw an exception when no hostname is given" {

            {New-BarracudaWAFService -IpAddress 'string' -Hostname '' } | Should Throw

        }
    }
}
