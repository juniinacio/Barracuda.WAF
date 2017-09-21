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
    https://campus.barracuda.com/product/webapplicationfirewall/article/WAF/RESTAPIContentRule/
#>
function Get-ContentRule {
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

        # RuleId help description
        [Parameter(
            Mandatory = $false,
            Position = 1,
            ValueFromPipeline = $true
        )]
        [ValidateNotNullOrEmpty()]        
        [String[]]
        $RuleId
    )

    process {
        if ($PSBoundParameters.ContainsKey('RuleId')) {
            foreach ($rule in $RuleId) {
                Invoke-API -Path $('/restapi/v1/virtual_services/{0}/content_rules/{1}' -f $VirtualServiceId, $rule)
            }
        } else {
            Invoke-API -Path $('/restapi/v1/virtual_services/{0}/content_rules' -f $VirtualServiceId)
        }
    }
}