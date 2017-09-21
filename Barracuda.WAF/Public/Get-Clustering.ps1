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
#>
function Get-Clustering {
    [CmdletBinding(
        DefaultParameterSetName='FirstNodeDetails'
    )]
    [Alias()]
    [OutputType([PSCustomObject])]
    Param (
        # ClusterSharedKey help description
        [Parameter(
            Mandatory = $true,
            Position = 0,
            ParameterSetName = 'ClusterSharedKey'
        )]
        [Switch]
        $ClusterSharedKey,

        # ClusterNodes help description
        [Parameter(
            Mandatory = $true,
            Position = 0,
            ParameterSetName = 'ConfigurationCluster'
        )]
        [Switch]
        $ConfigurationCluster
    )
    
    process {
        switch ($PSCmdlet.ParameterSetName) {
            ClusterSharedKey {
                Invoke-API -Path '/restapi/v1/system' -Parameters @{
                    parameters = 'cluster_shared_secret'
                }
            }

            ConfigurationCluster {
                Invoke-API -Path '/restapi/v1/system/configuration_cluster'
            }

            Default {
                Invoke-API -Path '/restapi/v1/system'
            }
        }
    }
}