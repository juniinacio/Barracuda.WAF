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
    https://campus.barracuda.com/product/webapplicationfirewall/article/WAF/RESTAPIServiceGroup/
#>
function Get-ServiceGroup {
    [CmdletBinding()]
    [Alias()]
    [OutputType([PSCustomObject])]
    Param (
        # VsiteId help description
        [Parameter(
            Mandatory = $true,
            Position = 0
        )]
        [ValidateNotNullOrEmpty()]        
        [String]
        $VsiteId,

        # ServiceGroupId help description
        [Parameter(
            Mandatory = $false,
            Position = 1,
            ValueFromPipeline = $true
        )]
        [ValidateNotNullOrEmpty()]        
        [String[]]
        $ServiceGroupId
    )
    
    process {
        if ($PSBoundParameters.ContainsKey('ServiceGroupId')) {
            foreach ($serviceGroup in $ServiceGroupId) {
                Invoke-API -Path $('/restapi/v1/vsites/{0}/service_groups/{1}' -f $VsiteId, $serviceGroup)
            }
        } else {
            Invoke-API -Path $('/restapi/v1/vsites/{0}/service_groups' -f $VsiteId)
        }
    }
}