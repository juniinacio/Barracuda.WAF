Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Update-BarracudaWAFServerSslPolicy" {

        It "should accept pipeline input" {
            Mock Invoke-Api {}

            $inputObject = @"
{
    "enable-ssl-3": "No",
    "enable-sni": "No",
    "enable-tls-1-1": "Yes",
    "enable-tls-1-2": "Yes",
    "enable-ssl-compatibility-mode": "No",
    "client-certificate": "string",
    "enable-https": "No",
    "validate-certificate": "Yes",
    "enable-tls-1": "No"
}       
"@          | ConvertFrom-Json

            $inputObject | Update-BarracudaWAFServerSslPolicy -WebApplicationName 'default' -WebServerName 'server1'

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/services/default/servers/server1/ssl-policy" `
                -and    $Method -eq 'Put' `
                -and    $PostData.'enable-ssl-3' -eq 'No' `
                -and    $PostData.'enable-sni' -eq 'No' `
                -and    $PostData.'enable-tls-1-1' -eq 'Yes' `
                -and    $PostData.'enable-tls-1-2' -eq 'Yes' `
                -and    $PostData.'enable-ssl-compatibility-mode' -eq 'No' `
                -and    $PostData.'client-certificate' -eq 'string' `
                -and    $PostData.'enable-https' -eq 'No' `
                -and    $PostData.'validate-certificate' -eq 'Yes' `
                -and    $PostData.'enable-tls-1' -eq 'No' `
            } -Scope It
        }

        It "should throw an exception when no web application name is given" {

            {Update-BarracudaWAFServerSslPolicy -WebApplicationName '' -WebServerName 'server1'} | Should Throw

        }

        It "should throw an exception when no web server name is given" {

            {Update-BarracudaWAFServerSslPolicy -WebApplicationName 'default' -WebServerName ''} | Should Throw

        }
    }
}
