Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Remove-BarracudaWAFSystemLocalhostInformation" {

        It "should remove local host information" {
            Mock Invoke-Api {}
            
            Remove-BarracudaWAFSystemLocalhostInformation

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/system/local-hosts" `
                -and    $Method -eq 'Delete'
            } -Scope It
        }
    }
}
