Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Update-BarracudaWAFSecurityPolicyRequestLimits" {

        It "should accept pipeline input" {
            Mock Invoke-Api {}

            $inputObject = @"
{
    "max-number-of-cookies": 0,
    "max-header-name-length": 0,
    "enable": "Yes",
    "max-request-length": 0,
    "max-number-of-headers": 0,
    "max-cookie-value-length": 0,
    "max-query-length": 0,
    "max-url-length": 0,
    "max-request-line-length": 0,
    "max-header-value-length": 0,
    "max-cookie-name-length": 0
}
"@          | ConvertFrom-Json

            $inputObject | Update-BarracudaWAFSecurityPolicyRequestLimits -PolicyName 'default'

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/security-policies/default/request-limits" `
                -and    $Method -eq "Put" `
                -and    $PostData."max-number-of-cookies" -eq 0 `
                -and    $PostData."max-header-name-length" -eq 0 `
                -and    $PostData."enable" -eq "Yes" `
                -and    $PostData."max-request-length" -eq 0 `
                -and    $PostData."max-number-of-headers" -eq 0 `
                -and    $PostData."max-cookie-value-length" -eq 0 `
                -and    $PostData."max-query-length" -eq 0 `
                -and    $PostData."max-url-length" -eq 0 `
                -and    $PostData."max-request-line-length" -eq 0 `
                -and    $PostData."max-header-value-length" -eq 0 `
                -and    $PostData."max-cookie-name-length" -eq 0 `
            } -Scope It
        }
    }
}