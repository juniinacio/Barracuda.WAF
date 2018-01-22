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
    https://campus.barracuda.com/product/webapplicationfirewall/article/WAF/RESTAPIServer/
#>
function Get-Server {
    [CmdletBinding()]
    [Alias()]
    [OutputType([PSCustomObject])]
    Param (
        # WebApplicationName help description
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]        
        [String]
        $WebApplicationName,

        # ServerName help description
        [Parameter(Mandatory = $false, ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]        
        [String[]]
        $ServerName
    )

    process {
        if ($PSBoundParameters.ContainsKey('ServerName')) {
            foreach ($name in $ServerName) {
                try {
                    Invoke-API -Path $('/restapi/v3/services/{0}/servers/{1}' -f $WebApplicationName, $name) -Method Get
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
        } else {
            Invoke-API -Path $('/restapi/v3/services/{0}/servers' -f $WebApplicationName) -Method Get
        }
    }
}