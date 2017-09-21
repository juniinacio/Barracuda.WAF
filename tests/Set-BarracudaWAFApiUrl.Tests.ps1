Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Set-BarracudaWAFApiUrl" {
        BeforeEach {
            $Script:BWAF_URI = $null
        }

        It "should store only the authority part form the url" {

            Set-BarracudaWAFApiUrl -Url "https://waf1.com/"

            $Script:BWAF_URI | Should BeExactly "https://waf1.com"
        }

        It "should strip the path from the url" {

            Set-BarracudaWAFApiUrl -Url "https://waf1.com/restapi/v1/login"

            $Script:BWAF_URI | Should BeExactly "https://waf1.com"
        }

        It "should strip the query string form the url" {

            Set-BarracudaWAFApiUrl -Url "https://waf1.com/restapi/v1/login?test=blah"

            $Script:BWAF_URI | Should BeExactly "https://waf1.com"
        }

        It "should accept pipeline input" {

            "https://waf1.com/restapi/v1/login?test=blah" | Set-BarracudaWAFApiUrl

            $Script:BWAF_URI | Should BeExactly "https://waf1.com"
        }
    }
}
