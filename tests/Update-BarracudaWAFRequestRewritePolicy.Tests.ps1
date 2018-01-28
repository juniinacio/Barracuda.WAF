Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Update-BarracudaWAFRequestRewritePolicy" {

        It "should accept pipeline input" {
            Mock Invoke-Api {}

            $inputObject = @"
{
    "old-value": "string",
    "sequence-number": 1,
    "name": "string",
    "action": "Insert Header",
    "rewrite-value": "string",
    "comments": "string",
    "header": "string",
    "continue-processing": "Yes",
    "condition": "string"
}       
"@          | ConvertFrom-Json

            $inputObject | Update-BarracudaWAFRequestRewritePolicy -WebApplicationName 'default' -RuleName 'rule1'

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/services/default/http-request-rewrite-rules/rule1" `
                -and    $Method -eq 'Put' `
                -and    $PostData.'old-value' -eq 'string' `
                -and    $PostData.'sequence-number' -eq '1' `
                -and    $PostData.name -eq 'string' `
                -and    $PostData.action -eq 'Insert Header' `
                -and    $PostData.'rewrite-value' -eq 'string' `
                -and    $PostData.comments -eq 'string' `
                -and    $PostData.header -eq 'string' `
                -and    $PostData.'continue-processing' -eq 'Yes' `
                -and    $PostData.condition -eq 'string'
            } -Scope It
        }

        It "should throw an exception when no web application name is given" {

            {Update-BarracudaWAFRequestRewritePolicy -WebApplicationName '' -SequenceNumber 1 -RuleName 'name1'} | Should Throw

        }

        It "should throw an exception when no sequence number is given" {

            {Update-BarracudaWAFRequestRewritePolicy -WebApplicationName 'default' -SequenceNumber '' -RuleName 'name1'} | Should Throw

        }

        It "should throw an exception when no rule name is given" {

            {Update-BarracudaWAFRequestRewritePolicy -WebApplicationName 'default' -SequenceNumber '1' -RuleName ''} | Should Throw

        }
    }
}
