Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "New-BarracudaWAFClusterNode" {

        It "should accept pipeline input" {
            Mock Invoke-Api {}

            $inputObject = @"
{
    "ip-address": "string"
}         
"@          | ConvertFrom-Json

            $inputObject | New-BarracudaWAFClusterNode

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq '/restapi/v3/cluster/nodes' `
                -and    $Method -eq 'Post' `
                -and    $PostData.'ip-address' -eq 'string' `
            } -Times 1
        }

        It "should throw an exception when no ip address is given" {

            {New-BarracudaWAFClusterNode -IpAddress ''} | Should Throw

        }
    }
}
