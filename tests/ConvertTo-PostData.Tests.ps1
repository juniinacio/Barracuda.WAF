Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "ConvertTo-PostData" {

        It "should convert camel case to snake case" {

            $inputObject = @{
                IpAddress = 'string'
            }

            $outputObject = $inputObject | ConvertTo-PostData

            ($outputObject.Keys -ccontains 'ip-address') | Should Be $true
            
        }

        It "should ignore given properties" {
            
            $inputObject = @{
                VSite = 'string'
            }

            $outputObject = $inputObject | ConvertTo-PostData -IgnoreProperty 'VSite'

            ($outputObject.Keys -ccontains 'vsite') | Should Be $true
            
        }

        It "should remove common command parameters" {
            
            $inputObject = @{
                Verbose = $true
            }

            $outputObject = $inputObject | ConvertTo-PostData -IgnoreProperty 'VSite'

            ($outputObject.Keys -notcontains 'verbose') | Should Be $true
            
        }
    }
}
