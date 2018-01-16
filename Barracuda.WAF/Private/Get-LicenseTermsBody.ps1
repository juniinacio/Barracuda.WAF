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
function Get-LicenseTermsBody {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$true, Position=0)]
        [ValidateNotNullOrEmpty()]
        [String]
        $Name,
        
        # Email help description
        [Parameter(Mandatory=$true, Position=2)]
        [ValidateNotNullOrEmpty()]
        [String]
        $Email,

        # Company help description
        [Parameter(Mandatory=$false, Position=3)]
        [AllowEmptyString()]
        [String]
        $Company
    )
    
    end {
        $htmlWebResponseObject = Invoke-WebRequest -Uri $Script:BWAF_URI -UseBasicParsing

        return @{
            name_sign = $Name
            email_sign = $Email
            company_sign = $Company
            eula_hash_val = $htmlWebResponseObject.InputFields.FindByName("eula_hash_val").value
            action = $htmlWebResponseObject.InputFields.FindByName("action").value
        }
    }
}