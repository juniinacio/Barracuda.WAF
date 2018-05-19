Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Update-BarracudaWAFServiceSslSecurity" {

        It "should accept pipeline input" {
            Mock Invoke-Api {}

            $inputObject = @"
{
    "ciphers": "Default",
    "enable-sni": "No",
    "status": "Off",
    "certificate": "string",
    "hsts-max-age": 0,
    "sni-certificate": 'string',
    "enable-strict-sni-check": "No",
    "ecdsa-certificate": "string",
    "domain": 'string',
    "enable-ssl-3": "No",
    "enable-tls-1-1": "Yes",
    "enable-hsts": "No",
    "enable-tls-1-2": "Yes",
    "include-hsts-sub-domains": "No",
    "sni-ecdsa-certificate": 'string',
    "selected-ciphers": "string",
    "enable-pfs": "No",
    "enable-tls-1": "No"
}         
"@          | ConvertFrom-Json

            $inputObject | Update-BarracudaWAFServiceSslSecurity -WebApplicationName 'demo'

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq '/restapi/v3/services/demo/ssl-security' `
                -and    $Method -eq 'Put' `
                -and    $PostData.ciphers -eq 'Default' `
                -and    $PostData.'enable-sni' -eq 'No' `
                -and    $PostData.status -eq 'Off' `
                -and    $PostData.certificate -eq 'string' `
                -and    $PostData.'hsts-max-age' -eq 0 `
                -and    $PostData.'sni-certificate' -eq 'string' `
                -and    $PostData.'enable-strict-sni-check' -eq 'No' `
                -and    $PostData.'ecdsa-certificate' -eq 'string' `
                -and    $PostData.domain -eq 'string' `
                -and    $PostData.'enable-ssl-3' -eq 'No' `
                -and    $PostData.'enable-tls-1-1' -eq 'Yes' `
                -and    $PostData.'enable-hsts' -eq 'No' `
                -and    $PostData.'enable-tls-1-2' -eq 'Yes' `
                -and    $PostData.'include-hsts-sub-domains' -eq 'No' `
                -and    $PostData.'sni-ecdsa-certificate' -eq 'string' `
                -and    $PostData.'selected-ciphers' -eq 'string' `
                -and    $PostData.'enable-pfs' -eq 'No' `
                -and    $PostData.'enable-tls-1' -eq 'No' `
            } -Times 1
        }

        It "should throw an exception when no name is given" {

            {Update-BarracudaWAFServiceSslSecurity -WebApplicationName '' -Ciphers 'Default'} | Should Throw

        }
    }
}
