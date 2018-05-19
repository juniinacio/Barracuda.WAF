Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Update-BarracudaWAFSecurityPolicyCookieSecurity" {

        It "should accept pipeline input" {
            Mock Invoke-Api {}

            $inputObject = @"
{
    "cookie-replay-protection-type": "IP",
    "custom-headers": "string",
    "secure-cookie": "No",
    "http-only": "No",
    "tamper-proof-mode": "Signed",
    "cookie-max-age": 0,
    "cookies-exempted": "string",
    "allow-unrecognized-cookies": "Custom",
    "days-allowed": "7"
}
"@          | ConvertFrom-Json

            $inputObject | Update-BarracudaWAFSecurityPolicyCookieSecurity -PolicyName 'default'

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/security-policies/default/cookie-security" `
                -and    $Method -eq "Put" `
                -and    $PostData."cookie-replay-protection-type" -eq "IP" `
                -and    $PostData."custom-headers" -eq "string" `
                -and    $PostData."secure-cookie" -eq "No" `
                -and    $PostData."http-only" -eq "No" `
                -and    $PostData."tamper-proof-mode" -eq "Signed" `
                -and    $PostData."cookie-max-age" -eq "0" `
                -and    $PostData."cookies-exempted" -eq "string" `
                -and    $PostData."allow-unrecognized-cookies" -eq "Custom" `
                -and    $PostData."days-allowed" -eq "7" `
            } -Scope It
        }
    }
}