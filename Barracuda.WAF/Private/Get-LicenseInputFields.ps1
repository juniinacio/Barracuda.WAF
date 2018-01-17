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
function Get-LicenseInputFields {
    Param (
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $Name,
        
        # Email help description
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $Email,

        # Company help description
        [Parameter(Mandatory=$false)]
        [AllowEmptyString()]
        [String]
        $Company
    )
    
    $webRequest = Invoke-WebRequest -Uri $Script:BWAF_URI -UseBasicParsing
    if ($webRequest.InputFields.FindByName("eula_hash_val") -ne $null) {
        return @{
            name_sign = $Name
            email_sign = $Email
            company_sign = $Company
            eula_hash_val = $webRequest.InputFields.FindByName("eula_hash_val").value
            action = $webRequest.InputFields.FindByName("action").value
        }
    }
}