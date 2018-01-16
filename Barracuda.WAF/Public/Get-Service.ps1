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
function Get-Service {
    [CmdletBinding()]
    [Alias()]
    [OutputType([PSCustomObject])]
    Param (
        # VirtualServiceId help description
        [Parameter(
            Mandatory = $false,
            Position = 0,
            ValueFromPipeline = $true
        )]
        [ValidateNotNullOrEmpty()]        
        [String[]]
        $VirtualServiceId
    )

    process {
        if ($PSBoundParameters.ContainsKey('VirtualServiceId')) {
            foreach ($virtualService in $VirtualServiceId) {
                Invoke-API -Path $('/restapi/v1/virtual_services/{0}' -f $virtualService)
            }
        } else {
            Invoke-API -Path '/restapi/v1/virtual_services'
        }
    }
}