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
    https://campus.barracuda.com/product/webapplicationfirewall/article/WAF/RESTAPISecPolicy/
#>
function Get-DataTheftProtection {
    [CmdletBinding()]
    [Alias()]
    [OutputType([PSCustomObject])]
    Param (
        # PolicyId help description
        [Parameter(
            Mandatory = $true,
            Position = 0
        )]
        [ValidateNotNullOrEmpty()]        
        [String]
        $PolicyId,

        # DataTheftProtectionId help description
        [Parameter(
            Mandatory = $false,
            Position = 1,
            ValueFromPipeline = $true
        )]
        [ValidateNotNullOrEmpty()]        
        [String[]]
        $DataTheftProtectionId
    )

    process {
        if ($PSBoundParameters.ContainsKey('DataTheftProtectionId')) {
            foreach ($dataTheftProtection in $DataTheftProtectionId) {
                Invoke-API -Path $('/restapi/v1/security_policies/{0}/data_theft_protection/{1}' -f $PolicyId, $dataTheftProtection)
            }
        } else {
            Invoke-API -Path $('/restapi/v1/security_policies/{0}/data_theft_protection' -f $PolicyId)
        }
    }
}