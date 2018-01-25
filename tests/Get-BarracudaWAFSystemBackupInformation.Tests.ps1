Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Get-BarracudaWAFSystemBackupInformation" {

        It "should retrieve information of backups" {
            Mock Invoke-Api {}

            Get-BarracudaWAFSystemBackupInformation

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/backup" `
                -and    $Method -eq 'Get'
            } -Scope It
        }
    }
}
