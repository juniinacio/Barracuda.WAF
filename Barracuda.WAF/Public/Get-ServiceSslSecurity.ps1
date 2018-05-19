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
function Get-ServiceSslSecurity {
    [CmdletBinding()]
    [Alias()]
    [OutputType([PSCustomObject])]
    Param (
        # WebApplicationName help description
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [String[]]
        $WebApplicationName,

        # Parameters help description
        [Parameter(Mandatory = $false)]
        [ValidateSet('certificate', 'ciphers', 'domain', 'ecdsa-certificate', 'enable-hsts', 'enable-pfs', 'enable-sni', 'enable-ssl-3', 'enable-strict-sni-check', 'enable-tls-1', 'enable-tls-1-1', 'enable-tls-1-2', 'hsts-max-age', 'include-hsts-sub-domains', 'override-ciphers-ssl3', 'override-ciphers-tls-1', 'override-ciphers-tls-1-1', 'selected-ciphers', 'sni-certificate', 'sni-ecdsa-certificate', 'status')]
        [String[]]
        $Parameters
    )

    process {
        try {
            $params = @{}

            if ($PSBoundParameters.ContainsKey('Parameters')) {
                $params.parameters = $Parameters -join ','
            }

            foreach ($name in $WebApplicationName) {
                Invoke-API -Path $('/restapi/v3/services/{0}/ssl-security' -f $name) -Method Get -Parameters $params
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