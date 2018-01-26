Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "New-BarracudaWAFServer" {

        It "should accept pipeline input" {
            Mock Invoke-Api {}

            $inputObject = @"
{
    "address-version": "IPv4",
    "status": "In Service",
    "name": "server1",
    "ip-address": "string",
    "port": 80,
    "comments": "string"
}       
"@          | ConvertFrom-Json

            $inputObject | New-BarracudaWAFServer -WebApplicationName 'default'

            Assert-MockCalled Invoke-Api -ParameterFilter {
                $Path -eq "/restapi/v3/services/default/servers" -and $Method -eq 'Post' -and $PostData.'name' -eq 'server1'
            } -Scope It
        }

        It "should support create server using ip address" {
            Mock Invoke-Api {}

            $inputObject = @"
{
    "address-version": "IPv4",
    "status": "In Service",
    "name": "server1",
    "ip-address": "192.168.1.1",
    "port": 80,
    "comments": "string"
}       
"@          | ConvertFrom-Json

            $inputObject | New-BarracudaWAFServer -WebApplicationName 'default'

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/services/default/servers" `
                -and    $Method -eq 'Post' `
                -and    $PostData.'address-version' -eq 'IPv4' `
                -and    $PostData.'status' -eq 'In Service' `
                -and    $PostData.'name' -eq 'server1' `
                -and    $PostData.'ip-address' -eq '192.168.1.1' `
                -and    $PostData.'port' -eq '80' `
                -and    $PostData.'comments' -eq 'string' `
                -and    $PostData.'identifier' -eq 'IP Address' `
            } -Scope It
        }

        It "should support create server using hostname" {
            Mock Invoke-Api {}

            $inputObject = @"
{
    "status": "In Service",
    "name": "server1",
    "hostname": "www.example.com",
    "port": 80,
    "comments": "string"
}       
"@          | ConvertFrom-Json

            $inputObject | New-BarracudaWAFServer -WebApplicationName 'default'

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/services/default/servers" `
                -and    $Method -eq 'Post' `
                -and    $PostData.'status' -eq 'In Service' `
                -and    $PostData.'name' -eq 'server1' `
                -and    $PostData.'hostname' -eq 'www.example.com' `
                -and    $PostData.'port' -eq '80' `
                -and    $PostData.'comments' -eq 'string' `
                -and    $PostData.'identifier' -eq 'Hostname'
            } -Scope It
        }

        It "should throw an exception when no web application name is given" {

            {New-BarracudaWAFServer -WebApplicationName ''} | Should Throw

        }
    }
}
