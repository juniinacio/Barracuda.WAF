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
function Remove-Service {
    [CmdletBinding()]
    [Alias()]
    [OutputType([PSCustomObject])]
    Param (
        # WebApplicationName help description
        [Parameter(
            Mandatory = $true,
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [ValidateLength(1, 64)]
        [Alias('Name')]
        [String[]]
        $WebApplicationName
    )

    process {
        foreach ($name in $WebApplicationName) {
            try {
                Invoke-API -Path ('/restapi/v3/services/{0}' -f $name) -Method Delete
            } catch {
                if ($_.Exception -is [System.Net.WebException]) {
                    if ($_.Exception.Response.StatusCode -ne 404) {
                        throw
                    }
                } else {
                    throw
                }
            }
        }
    }
}