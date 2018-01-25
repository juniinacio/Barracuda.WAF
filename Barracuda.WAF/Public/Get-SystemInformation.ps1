<#
.SYNOPSIS
    Short description
.DESCRIPTION
    Long description
.EXAMPLE
    Example of how to use this cmdlet
.EXAMPLE
    Another example of how to use this cmdlet
.INPUTS
    Inputs to this cmdlet (if any)
.OUTPUTS
    Output from this cmdlet (if any)
.NOTES
    General notes
.COMPONENT
    The component this cmdlet belongs to
.ROLE
    The role this cmdlet belongs to
.FUNCTIONALITY
    The functionality that best describes this cmdlet
.LINK
    https://campus.barracuda.com/product/webapplicationfirewall/api/9.1.1
#>
function Get-SystemInformation {
    [CmdletBinding()]
    [Alias()]
    [OutputType([PSCustomObject])]
    Param (
        # Groups help description
        [Parameter(Mandatory = $false)]
        [ValidateSet('Logs Format', 'Advanced Settings', 'Management Configuration', 'Pattern Mode', 'LAN Configuration' , 'Export Log Settings', 'Admin IP Range', 'Network Configuration', 'FTP Access Logs', 'Cookies and Parameters', 'Proxy Server', 'Password Policy', 'Web Interface', 'Location', 'Export Log Filters', 'NG Firewall', 'Email Notifications', 'System', 'Azure Configuration', 'WAN Configuration', 'SNMP', 'Secure Administration', 'Appearance', 'DNS', 'Energize Updates', 'Trap Receivers', 'Syslog Settings', 'Custom Headers', 'Local Hosts', 'Encryption Key', 'Module Log Levels', 'Account Lockout Settings')]
        [String[]]
        $Groups,

        # Parameters help description
        [Parameter(Mandatory = $false)]
        [ValidateSet('device-name', 'domain', 'enable-ipv6', 'hostname', 'interface-for-system-services', 'locale', 'model', 'operation-mode', 'serial', 'time-zone')]
        [String[]]
        $Parameters
    )

    process {

        $params = @{}

        if ($PSBoundParameters.ContainsKey('Groups')) {
            $params.groups = $Groups -join ','
        }

        if ($PSBoundParameters.ContainsKey('Parameters')) {
            $params.parameters = $Parameters -join ','
        }

        try {
            Invoke-API -Path '/restapi/v3/system' -Method Get -Parameters $params
        } catch {
            if ($_.Exception -is [System.Net.WebException]) {
                Write-Verbose "ExceptionResponse: `n$($_ | Get-ExceptionResponse)`n"
                if ($_.Exception.Response.StatusCode -ne 404) {
                    throw
                }
            } else {
                throw
            }
        }
    }
}