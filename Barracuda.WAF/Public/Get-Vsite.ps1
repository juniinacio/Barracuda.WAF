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
    https://campus.barracuda.com/product/webapplicationfirewall/article/WAF/RESTAPIVsites/
#>
function Get-Vsite {
    [CmdletBinding()]
    [Alias()]
    [OutputType([PSCustomObject])]
    Param (
        # VsiteId help description
        [Parameter(
            Mandatory = $false,
            Position = 0,
            ValueFromPipeline = $true
        )]
        [ValidateNotNullOrEmpty()]        
        [String[]]
        $VsiteId
    )
    
    process {
        if ($PSBoundParameters.ContainsKey('VsiteId')) {
            foreach ($Vsite in $VsiteId) {
                Invoke-API -Path $('/restapi/v1/vsites/{0}' -f $Vsite)
            }
        } else {
            Invoke-API -Path '/restapi/v1/vsites'
        }
    }
}