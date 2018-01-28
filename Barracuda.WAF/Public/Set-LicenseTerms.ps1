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
        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $Name,
        
        # Email help description
        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $Email,

        # Company help description
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName = $true)]
        [AllowEmptyString()]
        [String]
        $Company = "",

        # SKU help description
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('hourly', 'byol')]
        [String]
        $SKU = 'hourly'
    )
    
    process {
        try {
            $PSBoundParameters.Remove("SKU") | Out-Null

            switch ($SKU) {
                Default {
                    $fields = Get-LicenseInputFields @PSBoundParameters
                    if ($fields) {
                        $params = @{
                            Uri = $Script:BWAF_URI
                            UseBasicParsing = $true
                            Body = $fields
                            Method  = 'Post'
                        }
                        Invoke-WebRequest @params
                    }
                }
            }
        } catch {
            throw
        }
    }
}