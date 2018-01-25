Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Update-BarracudaWAFSystemDnsInformation" {

        It "should accept pipeline input" {
            Mock Invoke-Api {}

            $inputObject = @"
{
    "secondary-dns-server": "string",
    "primary-dns-server": "string"
}
"@          | ConvertFrom-Json

            $inputObject | Update-BarracudaWAFSystemDnsInformation

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/system/dns" `
                -and    $Method -eq 'Put' `
                -and    $PostData.'secondary-dns-server' -eq 'string' `
                -and    $PostData.'primary-dns-server' -eq 'string'
            } -Scope It
        }

        It "should throw an exception when no primary dns server is given" {

            {New-BarracudaWAFService -PrimaryDnsServer '' -SecondaryDnsServer '8.8.8.8' } | Should Throw

        }
    }
}
