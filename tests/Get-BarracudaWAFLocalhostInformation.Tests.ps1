﻿Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Get-BarracudaWAFLocalhostInformation" {

        It "should retrieve information of local hosts" {
            Mock Invoke-Api {}
            
            Get-BarracudaWAFLocalhostInformation

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/system/local-hosts" `
                -and    $Method -eq 'Get'
            } -Scope It
        }

        It "should retrieve a specific local host information parameter" {
            Mock Invoke-Api {}
            
            Get-BarracudaWAFLocalhostInformation -Parameters 'hostname'

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/system/local-hosts" `
                -and    $Method -eq 'Get'
            } -Scope It
        }
    }
}
