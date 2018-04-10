Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "New-BarracudaWAFSecurityPolicy" {

        It "should accept pipeline input" {
            Mock Invoke-Api {}

            $inputObject = @"
{
    "name": "development",
    "based-on": "default"
}
"@          | ConvertFrom-Json

            $inputObject | New-BarracudaWAFSecurityPolicy

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/security-policies" `
                -and    $Method -eq 'Post' `
                -and    $PostData.name -eq 'development' `
                -and    $PostData.'based-on' -eq 'default' `
            } -Scope It
        }
    }
}