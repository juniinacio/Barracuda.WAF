Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Update-BarracudaWAFUrlProfile" {

        It "should accept pipeline input" {
            Mock Invoke-Api {}

            $inputObject = @"
{
    "extended-match-sequence": 0,
    "hidden-parameter-protection": "Forms",
    "status": "On",
    "mode": "Passive",
    "exception-patterns": 'empty',
    "extended-match": "string",
    "allowed-methods": 'empty',
    "display-name": "string",
    "url": "string",
    "allowed-content-types": 'empty',
    "max-content-length": 0,
    "name": "string",
    "custom-blocked-attack-types": 'empty',
    "allow-query-string": "Yes",
    "csrf-prevention": "None",
    "referrers-for-the-url-profile": 'empty',
    "blocked-attack-types": 'empty',
    "comment": "string",
    "maximum-upload-files": 0,
    "maximum-parameter-name-length": 0
}
"@          | ConvertFrom-Json

            $inputObject | Update-BarracudaWAFUrlProfile -WebApplicationName 'default' -URLProfileName 'demo'

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/services/default/url-profiles/demo" `
                -and    $Method -eq 'Put' `
                -and    $PostData.'extended-match-sequence' -eq '0' `
                -and    $PostData.'hidden-parameter-protection' -eq 'Forms' `
                -and    $PostData.status -eq 'On' `
                -and    $PostData.mode -eq 'Passive' `
                -and    $PostData.'exception-patterns' -eq 'empty' `
                -and    $PostData.'extended-match' -eq 'string' `
                -and    $PostData.'allowed-methods' -eq 'empty' `
                -and    $PostData.'display-name' -eq 'string' `
                -and    $PostData.url -eq 'string' `
                -and    $PostData.'allowed-content-types' -eq 'empty' `
                -and    $PostData.'max-content-length' -eq '0' `
                -and    $PostData.name -eq 'string' `
                -and    $PostData.'custom-blocked-attack-types' -eq 'empty' `
                -and    $PostData.'allow-query-string' -eq 'Yes' `
                -and    $PostData.'csrf-prevention' -eq 'None' `
                -and    $PostData.'referrers-for-the-url-profile' -eq 'empty' `
                -and    $PostData.'blocked-attack-types' -eq 'empty' `
                -and    $PostData.comment -eq 'string' `
                -and    $PostData.'maximum-upload-files' -eq '0' `
                -and    $PostData.'maximum-parameter-name-length' -eq '0' `
            } -Scope It
        }
    }
}