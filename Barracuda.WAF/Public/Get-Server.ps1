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
    https://campus.barracuda.com/product/webapplicationfirewall/article/WAF/RESTAPIServer/
#>
function Get-Server {
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

        # ServerId help description
        [Parameter(
            Mandatory = $false,
            Position = 1,
            ValueFromPipeline = $true
        )]
        [ValidateNotNullOrEmpty()]        
        [String[]]
        $ServerId
    )

    process {
        if ($PSBoundParameters.ContainsKey('ServerId')) {
            foreach ($server in $ServerId) {
                Invoke-API -Path $('/restapi/v1/virtual_services/{0}/servers/{1}' -f $VirtualServiceId, $server)
            }
        } else {
            Invoke-API -Path $('/restapi/v1/virtual_services/{0}/servers' -f $VirtualServiceId)
        }
    }
}