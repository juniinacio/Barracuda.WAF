Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Get-BarracudaWAFServerSslPolicy" {

        It "should retrieve a server ssl policy" {
            Mock Invoke-Api {}

            Get-BarracudaWAFServerSslPolicy -WebApplicationName 'default' -WebServerName 'server1'

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/services/default/servers/server1/ssl-policy" -and $Method -eq 'Get' } -Scope It
        }

        It "should accept pipeline input" {
            Mock Invoke-Api {}
            
            "server1", "server2" | Get-BarracudaWAFServerSslPolicy -WebApplicationName 'default'

            Assert-MockCalled Invoke-Api -Times 2 -Scope It
        }

        It "should support parameters query string parameter" {
            Mock Invoke-Api {}

            $params = @('client-certificate', 'enable-https', 'enable-sni', 'enable-ssl-3', 'enable-ssl-compatibility-mode', 'enable-tls-1', 'enable-tls-1-1', 'enable-tls-1-2', 'validate-certificate')
            
            Get-BarracudaWAFServerSslPolicy -WebApplicationName 'default' -WebServerName 'server1' -Parameters $params

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/services/default/servers/server1/ssl-policy" -and $Parameters.parameters -eq ($params -join ',') } -Scope It
        }
    }
}
