Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Update-BarracudaWAFServer" {

        It "should support update server using ip address" {
            Mock Invoke-Api {}

            $inputObject = @"
{
    "address-version": "IPv4",
    "status": "In Service",
    "name": "server2",
    "ip-address": "string",
    "port": 80,
    "comments": "string"
}       
"@          | ConvertFrom-Json

            $inputObject | Update-BarracudaWAFServer -WebApplicationName 'default' -ServerName 'server1'

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/services/default/servers/server1" `
                -and    $Method -eq 'Put' `
                -and    $PostData.'address-version' -eq 'IPv4' `
                -and    $PostData.status -eq 'In Service' `
                -and    $PostData.name -eq 'server2' `
                -and    $PostData.'ip-address' -eq 'string' `
                -and    $PostData.port -eq 80 `
                -and    $PostData.comments -eq 'string' `
                -and    $PostData.identifier -eq 'IP Address' `
            } -Scope It
        }

        It "should support update server using hostname" {
            Mock Invoke-Api {}

            $inputObject = @"
{
    "status": "In Service",
    "name": "server2",
    "hostname": "string",
    "port": 80,
    "comments": "string"
}       
"@          | ConvertFrom-Json

            $inputObject | Update-BarracudaWAFServer -WebApplicationName 'default' -ServerName 'server1'

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/services/default/servers/server1" `
                -and    $Method -eq 'Put' `
                -and    $PostData.status -eq 'In Service' `
                -and    $PostData.name -eq 'server2' `
                -and    $PostData.hostname -eq 'string' `
                -and    $PostData.port -eq 80 `
                -and    $PostData.comments -eq 'string' `
                -and    $PostData.identifier -eq 'Hostname'
            } -Scope It
        }

        It "should throw an exception when no web application name is given" {

            {Update-BarracudaWAFServer -WebApplicationName '' -ServerName 'string'} | Should Throw

        }

        It "should throw an exception when no server name is given" {

            {Update-BarracudaWAFServer -WebApplicationName 'default' -ServerName '' -NewName 'new'} | Should Throw

        }
    }
}
