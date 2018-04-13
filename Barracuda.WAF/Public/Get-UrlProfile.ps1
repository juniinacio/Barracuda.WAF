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
    https://campus.barracuda.com/product/webapplicationfirewall/api/9.1.1
#>
function Get-UrlProfile {
    [CmdletBinding()]
    [Alias()]
    [OutputType([PSCustomObject])]
    Param (
        # WebApplicationName help description
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]        
        [String]
        $WebApplicationName,

        # URLProfileName help description
        [Parameter(Mandatory = $false, ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]        
        [String[]]
        $URLProfileName,

        # Parameters help description
        [Parameter(Mandatory = $false)]
        [ValidateSet('allow-query-string', 'allowed-content-types', 'allowed-methods', 'blocked-attack-types', 'comment', 'csrf-prevention', 'custom-blocked-attack-types', 'display-name', 'exception-patterns', 'extended-match', 'extended-match-sequence', 'hidden-parameter-protection', 'max-content-length', 'maximum-parameter-name-length', 'maximum-upload-files', 'mode', 'name', 'referrers-for-the-url-profile', 'status', 'url')]
        [String[]]
        $Parameters
    )

    process {
        try {
            $params = @{}

            if ($PSBoundParameters.ContainsKey('Parameters')) {
                $params.parameters = $Parameters -join ','
            }

            if ($PSBoundParameters.ContainsKey('URLProfileName')) {
                foreach ($name in $URLProfileName) {
                    Invoke-API -Path $('/restapi/v3/services/{0}/url-profiles/{1}' -f $WebApplicationName, $name) -Method Get -Parameters $params
                }
            } else {
                Invoke-API -Path $('/restapi/v3/services/{0}/url-profiles' -f $WebApplicationName) -Method Get -Parameters $params
            }
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
}