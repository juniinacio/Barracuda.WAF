Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Get-BarracudaWAFUrlProfile" {

        It "should retrieve a collection of url acls" {
            Mock Invoke-Api {}

            Get-BarracudaWAFUrlProfile -WebApplicationName 'default'

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/services/default/url-profiles" } -Scope It
        }

        It "should retrieve a single url acl" {
            Mock Invoke-Api {}
            
            Get-BarracudaWAFUrlProfile -WebApplicationName 'default' -URLProfileName 'demo'

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/services/default/url-profiles/demo" } -Scope It
        }

        It "should accept pipeline input" {

            'demo1', 'demo2' | Get-BarracudaWAFUrlProfile -WebApplicationName 'default'

            Assert-MockCalled Invoke-Api -Times 2 -Scope It

        }

        It "should support parameters query string parameter" {

            Mock Invoke-Api {}

            $params = @('allow-query-string', 'allowed-content-types', 'allowed-methods', 'blocked-attack-types', 'comment', 'csrf-prevention', 'custom-blocked-attack-types', 'display-name', 'exception-patterns', 'extended-match', 'extended-match-sequence', 'hidden-parameter-protection', 'max-content-length', 'maximum-parameter-name-length', 'maximum-upload-files', 'mode', 'name', 'referrers-for-the-url-profile', 'status', 'url')
            
            Get-BarracudaWAFUrlProfile -WebApplicationName 'default' -Parameters $params

            Assert-MockCalled Invoke-Api -ParameterFilter { $Path -eq "/restapi/v3/services/default/url-profiles" -and $Parameters.parameters -eq ($params -join ',') } -Scope It
        }
    }
}
