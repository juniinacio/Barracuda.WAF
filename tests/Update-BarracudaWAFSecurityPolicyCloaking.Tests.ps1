Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Update-BarracudaWAFSecurityPolicyCloaking" {

        It "should accept pipeline input" {
            Mock Invoke-Api {}

            $inputObject = @"
{
    "filter-response-header": "Yes",
    "return-codes-to-exempt": 500,
    "headers-to-filter": 1,
    "suppress-return-code": "Yes"
}
"@          | ConvertFrom-Json

            $inputObject | Update-BarracudaWAFSecurityPolicyCloaking -PolicyName 'default'

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/security-policies/default/cloaking" `
                -and    $Method -eq "Put" `
                -and    $PostData."filter-response-header" -eq "Yes" `
                -and    $PostData."return-codes-to-exempt" -eq "500" `
                -and    $PostData."headers-to-filter" -eq "1" `
                -and    $PostData."suppress-return-code" -eq "Yes" `
            } -Scope It
        }
    }
}