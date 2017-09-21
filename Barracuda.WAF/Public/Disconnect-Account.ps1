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
    https://campus.barracuda.com/product/webapplicationfirewall/article/WAF/RESTAPIv1/
#>
function Disconnect-Account {
    [CmdletBinding()]
    [Alias()]
    [OutputType([PSCustomObject])]
    Param ()
    
    process {
        Invoke-API -Path '/restapi/v1/logout' -Method Delete
    }

    end {
        $Script:BWAF_TOKEN = $null
    }
}