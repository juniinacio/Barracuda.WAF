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
function Update-Cluster {
    [CmdletBinding()]
    [Alias()]
    [OutputType([PSCustomObject])]
    Param (
        # MonitorLink help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('WAN', 'LAN', 'MGMT')]
        [Alias('monitor-link')]    
        [String]
        $MonitorLink,

        # FailbackMode help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('Automatic', 'Manual')]
        [Alias('failback-mode')]    
        [String]
        $FailbackMode,

        # HeartbeatFrequency help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateRange(1, 100)]
        [Alias('heartbeat-frequency')]    
        [int]
        $HeartbeatFrequency = 3,

        # ClusterSharedSecret help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('cluster-shared-secret')]    
        [String]
        $ClusterSharedSecret,

        # ClusterName help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('cluster-name')]    
        [String]
        $ClusterName,

        # HeartbeatCountPerInterface help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateRange(1, 200)]
        [Alias('heartbeat-count-per-interface')]    
        [int]
        $HeartbeatCountPerInterface = 2,

        # TransmitHeartbeatOn help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('WAN', 'LAN', 'MGMT')]
        [Alias('transmit-heartbeat-on')]    
        [String]
        $TransmitHeartbeatOn,

        # DataPathFailureAction help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('Attempt recovery', 'Failover')]
        [Alias('data-path-failure-action')]    
        [String]
        $DataPathFailureAction
    )

    process {
        try {
            $PSBoundParameters |
                ConvertTo-Post |
                    Invoke-API -Path '/restapi/v3/cluster' -Method Put
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