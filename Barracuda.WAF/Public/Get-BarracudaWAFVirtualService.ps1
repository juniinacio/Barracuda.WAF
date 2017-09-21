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
function Get-BarracudaWAFVirtualService {
    [CmdletBinding()]
    [Alias()]
    [OutputType([String])]
    Param (
        # Id help description
        [Parameter(
            Mandatory = $false,
            Position = 0,
            ValueFromPipeline = $true
        )]
        [ValidateNotNullOrEmpty()]        
        [String[]]
        $Id
    )

    process {
        if ($PSBoundParameters.ContainsKey('Id')) {
            foreach ($virtualService in $Id) {
                Invoke-API -Path $('/restapi/v1/virtual_services/{0}' -f $virtualService)
            }
        } else {
            Invoke-API -Path '/restapi/v1/virtual_services'
        }
    }
}