Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Set-BarracudaWAFClusterNode" {

        It "should accept pipeline input" {
            Mock Invoke-Api {}

            $inputObject = @"
{
    "operation": "failover"
}         
"@          | ConvertFrom-Json

            $inputObject | Set-BarracudaWAFClusterNode

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq '/restapi/v3/cluster/nodes' `
                -and    $Method -eq 'Post' `
                -and    $PostData.operation -eq 'failover' `
            } -Times 1
        }

        It "should throw an exception when no ip address is given" {

            {Set-BarracudaWAFClusterNode -Operation ''} | Should Throw

        }
    }
}
