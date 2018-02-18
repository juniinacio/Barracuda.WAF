Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Update-BarracudaWAFUrlAcl" {

        It "should accept pipeline input" {
            Mock Invoke-Api {}

            $inputObject = @"
{
    "response-page": "string",
    "extended-match-sequence": 1,
    "enable": "On",
    "redirect-url": "string",
    "deny-response": "Response Page",
    "name": "string",
    "extended-match": "string",
    "follow-up-action": "None",
    "comments": "string",
    "host": "string",
    "follow-up-action-time": 60,
    "url": "string",
    "action": "Process"
}
"@          | ConvertFrom-Json

            $inputObject | Update-BarracudaWAFUrlAcl -WebApplicationName 'default' -URLACLName 'demo'

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/services/default/url-acls/demo" `
                -and    $Method -eq 'Put' `
                -and    $PostData.'response-page' -eq 'string' `
                -and    $PostData.'extended-match-sequence' -eq 1 `
                -and    $PostData.enable -eq 'On' `
                -and    $PostData.'redirect-url' -eq 'string' `
                -and    $PostData.'deny-response' -eq 'Response Page' `
                -and    $PostData.name -eq 'string' `
                -and    $PostData.'extended-match' -eq 'string' `
                -and    $PostData.'follow-up-action' -eq 'None' `
                -and    $PostData.comments -eq 'string' `
                -and    $PostData.host -eq 'string' `
                -and    $PostData.'follow-up-action-time' -eq '60' `
                -and    $PostData.url -eq 'string' `
                -and    $PostData.action -eq 'Process' `
            } -Scope It
        }
    }
}