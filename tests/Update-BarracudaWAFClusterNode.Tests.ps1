Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Update-BarracudaWAFClusterNode" {

        It "should accept pipeline input" {
            Mock Invoke-Api {}

            $inputObject = @"
{
    "ip-address": "string",
    "mode": "string",
    "serial": "string"
}         
"@          | ConvertFrom-Json

            $inputObject | Update-BarracudaWAFClusterNode

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq '/restapi/v3/cluster/nodes' `
                -and    $Method -eq 'Put' `
                -and    $PostData.'ip-address' -eq 'string' `
                -and    $PostData.mode -eq 'string' `
                -and    $PostData.serial -eq 'string' `
            } -Times 1
        }

        It "should throw an exception when no ip address is given" {

            {Update-BarracudaWAFClusterNode -IpAddress '' -Mode 'string' -Serial 'string'} | Should Throw

        }

        It "should throw an exception when no mode is given" {

            {Update-BarracudaWAFClusterNode -IpAddress 'string' -Mode '' -Serial 'string'} | Should Throw

        }

        It "should throw an exception when no serial is given" {

            {Update-BarracudaWAFClusterNode -IpAddress 'string' -Mode 'string' -Serial ''} | Should Throw

        }
    }
}
