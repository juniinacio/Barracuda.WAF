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
function Get-RuleGroupServer {
    [CmdletBinding()]
    [Alias()]
    [OutputType([PSCustomObject])]
    Param (
        # WebApplicationName help description
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]        
        [String]
        $WebApplicationName,

        # RuleGroupName help description
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]        
        [String]
        $RuleGroupName,

        # WebServerName help description
        [Parameter(Mandatory = $false, ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]        
        [String]
        $WebServerName,

        # Groups help description
        [Parameter(Mandatory = $false)]
        [ValidateSet('Rule Group Server', 'Connection Pooling', 'Redirect', 'SSL Policy', 'Advanced Configuration', 'In Band Health Checks', 'Application Layer Health Checks', 'Out of Band Health Checks')]   
        [String[]]
        $Groups,

        # Parameters help description
        [Parameter(Mandatory = $false)]
        [ValidateSet('address-version', 'backup-server', 'comments', 'hostname', 'identifier', 'ip-address', 'name', 'port', 'status', 'weight')]   
        [String[]]
        $Parameters
    )

    process {
        try {
            $params = @{}

            if ($PSBoundParameters.ContainsKey('Groups')) {
                $params.groups = $Groups -join ','
            }

            if ($PSBoundParameters.ContainsKey('Parameters')) {
                $params.parameters = $Parameters -join ','
            }

            if ($PSBoundParameters.ContainsKey('WebServerName')) {
                foreach ($name in $WebServerName) {
                    Invoke-API -Path $('/restapi/v3/services/{0}/content-rules/{1}/content-rule-servers/{2}' -f $WebApplicationName, $RuleGroupName, $name) -Method Get -Parameters $params
                }
            } else {
                Invoke-API -Path $('/restapi/v3/services/{0}/content-rules/{1}/content-rule-servers' -f $WebApplicationName, $RuleGroupName) -Method Get -Parameters $params
            }
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