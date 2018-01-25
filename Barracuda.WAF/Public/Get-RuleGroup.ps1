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
function Get-RuleGroup {
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
        [Parameter(Mandatory = $false, ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]        
        [String]
        $RuleGroupName,

        # Groups help description
        [Parameter(Mandatory = $false)]
        [ValidateSet('Logging', 'Caching', 'Load Balancing', 'Compression', 'Rule Group')]   
        [String[]]
        $Groups,

        # Parameters help description
        [Parameter(Mandatory = $false)]
        [ValidateSet('access-log', 'app-id', 'comments', 'extended-match', 'extended-match-sequence', 'host-match', 'mode', 'name', 'status', 'url-match', 'web-firewall-policy')]   
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

        if ($PSBoundParameters.ContainsKey('RuleGroupName')) {
            foreach ($name in $RuleGroupName) {
                try {
                    Invoke-API -Path $('/restapi/v3/services/{0}/content-rules/{1}' -f $WebApplicationName, $name) -Method Get -Parameters $params
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
        } else {
            Invoke-API -Path $('/restapi/v3/services/{0}/content-rules' -f $WebApplicationName) -Method Get -Parameters $params
        }
    }
}