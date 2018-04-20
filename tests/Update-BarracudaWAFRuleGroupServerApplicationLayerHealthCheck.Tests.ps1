Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Update-BarracudaWAFRuleGroupServerApplicationLayerHealthCheck" {

        It "should accept pipeline input" {
            Mock Invoke-Api {}

            $inputObject = @"
{
    "domain": "string",
    "match-content-string": "string",
    "url": "string",
    "additional-headers": 'string',
    "method": "GET",
    "status-code": 200
}       
"@          | ConvertFrom-Json

            $inputObject | Update-BarracudaWAFRuleGroupServerApplicationLayerHealthCheck -WebApplicationName 'default' -RuleGroupName 'group1' -WebServerName 'server1'

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/services/default/content-rules/group1/content-rule-servers/server1/application-layer-health-checks" `
                -and    $Method -eq 'Put' `
                -and    $PostData.domain -eq 'string' `
                -and    $PostData.'match-content-string' -eq 'string' `
                -and    $PostData.url -eq 'string' `
                -and    $PostData.'additional-headers' -eq 'string' `
                -and    $PostData.method -eq 'GET' `
                -and    $PostData.'status-code' -eq '200' `
            } -Scope It
        }

        It "should throw an exception when no web application name is given" {

            {Update-BarracudaWAFRuleGroupServerApplicationLayerHealthCheck -WebApplicationName '' -RuleGroupName 'group1' -WebServerName 'server1'} | Should Throw

        }

        It "should throw an exception when no rule group name is given" {

            {Update-BarracudaWAFRuleGroupServerApplicationLayerHealthCheck -WebApplicationName 'default' -RuleGroupName '' -WebServerName 'server1'} | Should Throw

        }

        It "should throw an exception when no web server name is given" {

            {Update-BarracudaWAFRuleGroupServerApplicationLayerHealthCheck -WebApplicationName 'default' -RuleGroupName 'group1' -WebServerName ''} | Should Throw

        }
    }
}
