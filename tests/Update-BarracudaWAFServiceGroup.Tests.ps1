Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Update-BarracudaWAFServiceGroup" {
        BeforeAll {
            $Script:BWAF_URI = "https://waf1.com"

            $Script:BWAF_TOKEN = [PSCustomObject]@{
                token = "eyJldCI6IjEzODAyMzE3NTciLCJwYXNzd29yZCI6ImY3NzY2ZTFmNTgwMzgyNmE1YTAzZWZlMzcy\nYzgzOTMyIiwidXNlciI6ImFkbWluIn0="
            }
        }

        It "should accept pipeline input" {
            Mock Invoke-Api {}

            $inputObject = @"
{
    "service-group": "string"
}        
"@          | ConvertFrom-Json

            $inputObject | Update-BarracudaWAFServiceGroup -VSite 'default' -Name 'group'

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/vsites/default/service-groups/group" -and $Method -eq 'Patch' -and $PostData.'service-group' -eq 'string'}
        }

        It "should throw an exception when no vsite is given" {

            {Update-BarracudaWAFServiceGroup -VSite '' -Name 'string'} | Should Throw

        }

        It "should throw an exception when no name is given" {

            {Update-BarracudaWAFServiceGroup -VSite 'default' -Name '' -NewName 'new'} | Should Throw

        }

        It "should throw an exception when no name is given" {

            {Update-BarracudaWAFServiceGroup -VSite 'default' -Name 'name' -NewName ''} | Should Throw

        }
    }
}
