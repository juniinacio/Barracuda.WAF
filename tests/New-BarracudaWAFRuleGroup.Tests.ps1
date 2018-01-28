Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "New-BarracudaWAFRuleGroup" {

        It "should accept pipeline input" {
            Mock Invoke-Api {}

            $inputObject = @"
{
    "extended-match-sequence": 1,
    "access-log": "Enable",
    "url-match": "string",
    "status": "On",
    "mode": "Passive",
    "name": "string",
    "extended-match": "string",
    "comments": "string",
    "web-firewall-policy": "string",
    "app-id": "string",
    "host-match": "string"
}
"@          | ConvertFrom-Json

            $inputObject | New-BarracudaWAFRuleGroup -WebApplicationName 'webApp1'

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/services/webApp1/content-rules" `
                -and    $Method -eq 'Post' `
                -and    $PostData.'extended-match-sequence' -eq '1' `
                -and    $PostData.'access-log' -eq 'Enable' `
                -and    $PostData.'url-match' -eq 'string' `
                -and    $PostData.status -eq 'On' `
                -and    $PostData.mode -eq 'Passive' `
                -and    $PostData.name -eq 'string' `
                -and    $PostData.'extended-match' -eq 'string' `
                -and    $PostData.comments -eq 'string' `
                -and    $PostData.'web-firewall-policy' -eq 'string' `
                -and    $PostData.'app-id' -eq 'string' `
                -and    $PostData.'host-match' -eq 'string'
            } -Scope It
        }

        It "should throw an exception when no web application name is given" {

            {New-BarracudaWAFRuleGroup -WebApplicationName '' -UrlMatch '/*' -Name 'group1' -HostMatch 'host-match'} | Should Throw

        }

        It "should throw an exception when no url-match is given" {

            {New-BarracudaWAFRuleGroup -WebApplicationName 'webApp1' -UrlMatch '' -Name 'name' -HostMatch 'host-match'} | Should Throw

        }

        It "should throw an exception when no rule group name is given" {

            {New-BarracudaWAFRuleGroup -WebApplicationName 'webApp1' -UrlMatch '/*' -Name 'name' -HostMatch ''} | Should Throw

        }
    }
}
