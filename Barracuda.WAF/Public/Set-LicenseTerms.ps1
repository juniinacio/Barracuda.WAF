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
function Set-LicenseTerms {
    [CmdletBinding()]
    Param (
        # Name help description
        [Parameter(Mandatory=$true, Position=0)]
        [ValidateNotNullOrEmpty()]
        [String]
        $Name,
        
        # Email help description
        [Parameter(Mandatory=$true, Position=1)]
        [ValidateNotNullOrEmpty()]
        [String]
        $Email,

        # Company help description
        [Parameter(Mandatory=$false, Position=2)]
        [AllowEmptyString()]
        [String]
        $Company,

        # SKU help description
        [Parameter(Mandatory=$false, Position=4)]
        [ValidateSet('hourly', 'byol')]
        [String]
        $SKU = 'hourly'
    )
    
    end {
        $PSBoundParameters.Remove("SKU") | Out-Null

        switch ($SKU) {
            Default {
                $params = @{
                    Uri = $Script:BWAF_URI
                    UseBasicParsing = $true
                    Body = Get-LicenseTermsBody @PSBoundParameters
                    Method  = 'Post'
                }
            }
        }

        $request = Invoke-WebRequest @params
    }
}