Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Get-BarracudaWAFRequestRewritePolicy" {

        It "should retrieve a collection of request rewrite policies" {
            Mock Invoke-Api {}

            Get-BarracudaWAFRequestRewritePolicy -WebApplicationName 'default'

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/services/default/http-request-rewrite-rules" `
                -and    $Method -eq 'Get'
            } -Scope It
        }

        It "should retrieve a request rewrite policy" {
            Mock Invoke-Api {}

            Get-BarracudaWAFRequestRewritePolicy -WebApplicationName 'default' -RuleName 'rule1'

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/services/default/http-request-rewrite-rules/rule1" `
                -and    $Method -eq 'Get'
            } -Scope It
        }

        It "should accept pipeline input" {
            Mock Invoke-Api {}
            
            "rule1", "rule2" | Get-BarracudaWAFRequestRewritePolicy -WebApplicationName 'default'

            Assert-MockCalled Invoke-Api -Times 2 -Scope It
        }

        It "should support parameters query string parameter" {
            Mock Invoke-Api {}

            $params = @('action', 'comments', 'condition', 'continue-processing', 'header', 'name', 'old-value', 'rewrite-value', 'sequence-number')
            
            Get-BarracudaWAFRequestRewritePolicy -WebApplicationName 'default' -Parameters $params

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/services/default/http-request-rewrite-rules" `
                -and    $Parameters.parameters -eq ($params -join ',')
            } -Scope It
        }
    }
}
