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
    https://campus.barracuda.com/product/webapplicationfirewall/doc/73698479/rest-api-version-3-v3/
#>
function Get-Cluster {
    [CmdletBinding()]
    [Alias()]
    [OutputType([PSCustomObject])]
    Param (
        # Groups help description
        [Parameter(Mandatory = $false)]
        [ValidateSet('Cluster', 'Nodes')]
        [String[]]
        $Groups,

        # Limit help description
        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [int]
        $Limit,

        # Offset help description
        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [int]
        $Offset,

        # Parameters help description
        [Parameter(Mandatory = $false)]
        [ValidateSet('cluster-name', 'data-path-failure-action', 'failback-mode', 'heartbeat-count-per-interface', 'heartbeat-frequency', 'monitor-link', 'transmit-heartbeat-on')]
        [String[]]
        $Parameters
    )

    process {
        try {
            $params = @{}

            if ($PSBoundParameters.ContainsKey('Groups')) {
                $params.groups = $Groups -join ','
            }

            if ($PSBoundParameters.ContainsKey('Limit')) {
                $params.limit = $Limit
            }

            if ($PSBoundParameters.ContainsKey('Offset')) {
                $params.offset = $Offset
            }

            if ($PSBoundParameters.ContainsKey('Parameters')) {
                $params.parameters = $Parameters -join ','
            }

            Invoke-API -Path '/restapi/v3/cluster' -Method Get -Parameters $params
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