Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Get-BarracudaWAFApiUrl" {
        BeforeEach {
            $Script:WAF_URI = "https://waf1.com/restapi/v1/login"
        }

        It "should return the Api url" {

            Get-BarracudaWAFApiUrl | Should BeExactly "https://waf1.com/restapi/v1/login"
        }
    }
}
