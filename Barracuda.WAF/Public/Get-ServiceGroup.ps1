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
    https://campus.barracuda.com/product/webapplicationfirewall/article/WAF/RESTAPIServiceGroup/
#>
function Get-ServiceGroup {
    [CmdletBinding()]
    [Alias()]
    [OutputType([PSCustomObject])]
    Param (
        # VsiteId help description
        [Parameter(Mandatory = $true, Position = 0)]
        [ValidateNotNullOrEmpty()]        
        [String]
        $VSite,

        # Name help description
        [Parameter(Mandatory = $false, Position = 1, ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('service-group')]
        [String[]]
        $Name
    )
    
    process {
        if ($PSBoundParameters.ContainsKey('Name')) {
            foreach ($n in $Name) {
                try {
                    Invoke-API -Path $('/restapi/v3/vsites/{0}/service-groups/{1}' -f $VSite, $n) -Method Get
                } catch {
                    if ($_.Exception -is [System.Net.WebException]) {
                        Write-Verbose "ExceptionResponse: `n$($_ | Get-ExceptionResponse)`n"
                        if ($_.Exception.Response.StatusCode -ne 404) {
                            throw
                        }
                    } else {
                        throw
                    }
                }
            }
        } else {
            Invoke-API -Path $('/restapi/v3/vsites/{0}/service-groups' -f $VSite) -Method Get
        }
    }
}