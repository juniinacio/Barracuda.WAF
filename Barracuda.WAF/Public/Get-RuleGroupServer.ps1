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
    https://campus.barracuda.com/product/webapplicationfirewall/article/WAF/RESTAPIRGServer/
#>
function Get-RuleGroupServer {
    [CmdletBinding()]
    [Alias()]
    [OutputType([PSCustomObject])]
    Param (
        # VirtualServiceId help description
        [Parameter(
            Mandatory = $true,
            Position = 0
        )]
        [ValidateNotNullOrEmpty()]        
        [String]
        $VirtualServiceId,

        # RuleId help description
        [Parameter(
            Mandatory = $true,
            Position = 1
        )]
        [ValidateNotNullOrEmpty()]        
        [String]
        $RuleId,

        # RGServerId help description
        [Parameter(
            Mandatory = $false,
            Position = 2,
            ValueFromPipeline = $true
        )]
        [ValidateNotNullOrEmpty()]        
        [String[]]
        $RGServerId
    )

    process {
        if ($PSBoundParameters.ContainsKey('RGServerId')) {
            foreach ($RGServer in $RGServerId) {
                Invoke-API -Path $('/restapi/v1/virtual_services/{0}/content_rules/{1}/rg_servers/{2}' -f $VirtualServiceId, $RuleId, $RGServer)
            }
        } else {
            Invoke-API -Path $('/restapi/v1/virtual_services/{0}/content_rules/{1}/rg_servers' -f $VirtualServiceId, $RuleId)
        }
    }
}