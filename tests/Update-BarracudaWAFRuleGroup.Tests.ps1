Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Update-BarracudaWAFRuleGroup" {

        It "should accept pipeline input" {
            Mock Invoke-Api {}

            $inputObject = @"
{
    "extended-match-sequence": 0,
    "access-log": "Enable",
    "url-match": "url",
    "status": "On",
    "mode": "Passive",
    "name": "name",
    "extended-match": "string",
    "comments": "string",
    "web-firewall-policy": "string",
    "app-id": "string",
    "host-match": "host"
}
"@          | ConvertFrom-Json

            $inputObject | Update-BarracudaWAFRuleGroup -WebApplicationName 'webApp1' -RuleGroupName 'group1'

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/services/webApp1/content-rules/group1" -and $Method -eq 'Put' -and $PostData.'url-match' -eq 'url' -and $PostData.'name' -eq 'name' -and $PostData.'host-match' -eq 'host' } -Scope It
        }

        It "should throw an exception when no web application name is given" {

            {Update-BarracudaWAFRuleGroup -WebApplicationName '' -RuleGroupName 'group1' -NewRuleGroupName 'group2' -UrlMatch 'url' -HostMatch 'host'} | Should Throw

        }

        It "should throw an exception when no rule group name is given" {

            {Update-BarracudaWAFRuleGroup -WebApplicationName 'webApp1' -RuleGroupName '' -NewRuleGroupName 'group2' -UrlMatch 'url' -HostMatch 'host'} | Should Throw

        }

        It "should throw an exception when no url match is given" {

            {Update-BarracudaWAFRuleGroup -WebApplicationName 'webApp1' -RuleGroupName 'group1' -NewRuleGroupName 'group2' -UrlMatch '' -HostMatch 'host'} | Should Throw

        }

        It "should throw an exception when no host match is given" {

            {Update-BarracudaWAFRuleGroup -WebApplicationName 'webApp1' -RuleGroupName 'group1' -NewRuleGroupName 'group2' -UrlMatch 'url' -HostMatch ''} | Should Throw

        }
    }
}
