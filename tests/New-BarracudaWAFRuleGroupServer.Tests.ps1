Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "New-BarracudaWAFRuleGroupServer" {

        It "should support creating rule group server using ip address" {
            Mock Invoke-Api {}

            $inputObject = @"
{
    "backup-server": "No",
    "address-version": "IPv4",
    "status": "In Service",
    "name": "string",
    "port": 80,
    "comments": "string",
    "weight": 1,
    "ip-address": "string"
}
"@          | ConvertFrom-Json

            $inputObject | New-BarracudaWAFRuleGroupServer -WebApplicationName 'webApp1' -RuleGroupName 'group1'

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/services/webApp1/content-rules/group1/content-rule-servers" `
                -and    $Method -eq 'Post' `
                -and    $PostData.'backup-server' -eq 'No' `
                -and    $PostData.'address-version' -eq 'IPv4' `
                -and    $PostData.status -eq 'In Service' `
                -and    $PostData.name -eq 'string' `
                -and    $PostData.port -eq '80' `
                -and    $PostData.comments -eq 'string' `
                -and    $PostData.weight -eq '1' `
                -and    $PostData.'ip-address' -eq 'string' `
                -and    $PostData.identifier -eq 'IP Address'
            } -Scope It
        }

        It "should support creating rule group server using hostname" {
            Mock Invoke-Api {}

            $inputObject = @"
{
    "backup-server": "No",
    "status": "In Service",
    "name": "string",
    "hostname": "string",
    "port": 80,
    "comments": "string",
    "weight": 1
}
"@          | ConvertFrom-Json

            $inputObject | New-BarracudaWAFRuleGroupServer -WebApplicationName 'webApp1' -RuleGroupName 'group1'

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/services/webApp1/content-rules/group1/content-rule-servers" `
                -and    $Method -eq 'Post' `
                -and    $PostData.'backup-server' -eq 'No' `
                -and    $PostData.status -eq 'In Service' `
                -and    $PostData.name -eq 'string' `
                -and    $PostData.hostname -eq 'string' `
                -and    $PostData.port -eq '80' `
                -and    $PostData.comments -eq 'string' `
                -and    $PostData.weight -eq '1' `
                -and    $PostData.identifier -eq 'Hostname'
            } -Scope It
        }

        It "should throw an exception when no web application name is given" {

            {New-BarracudaWAFRuleGroupServer -WebApplicationName '' -RuleGroupName 'group1' -Name 'server1'} | Should Throw

        }

        It "should throw an exception when no rule group name is given" {

            {New-BarracudaWAFRuleGroupServer -WebApplicationName 'webApp1' -RuleGroupName '' -Name 'server1'} | Should Throw

        }

        It "should throw an exception when no web server name is given" {

            {New-BarracudaWAFRuleGroupServer -WebApplicationName 'webApp1' -RuleGroupName 'group1' -Name ''} | Should Throw

        }
    }
}
