Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "New-BarracudaWAFRequestRewritePolicy" {

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

            $inputObject | New-BarracudaWAFRequestRewritePolicy -WebApplicationName 'default'

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/services/default/http-request-rewrite-rules" `
                -and    $Method -eq 'Post' `
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

            {New-BarracudaWAFRequestRewritePolicy -WebApplicationName '' -SequenceNumber 1 -Name 'name1'} | Should Throw

        }

        It "should throw an exception when no sequence number is given" {

            {New-BarracudaWAFRequestRewritePolicy -WebApplicationName 'default' -SequenceNumber '' -Name 'name1'} | Should Throw

        }

        It "should throw an exception when no name is given" {

            {New-BarracudaWAFRequestRewritePolicy -WebApplicationName 'default' -SequenceNumber '1' -Name ''} | Should Throw

        }
    }
}
