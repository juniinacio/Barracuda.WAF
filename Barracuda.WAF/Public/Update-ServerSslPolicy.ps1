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
function Update-ServerSslPolicy {
    [CmdletBinding()]
    [Alias()]
    [OutputType([PSCustomObject])]
    Param (
        # WebApplicationName help description
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]        
        [String]
        $WebApplicationName,

        # WebServerName help description
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]        
        [String]
        $WebServerName,

        # EnableSsl3 help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('enable-ssl-3')]
        [ValidateSet('Yes', 'No')]
        [String]
        $EnableSsl3 = 'No',

        # EnableSni help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('enable-sni')]
        [ValidateSet('Yes', 'No')]
        [String]
        $EnableSni = 'No',

        # EnableTls11 help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('enable-tls-1-1')]
        [ValidateSet('Yes', 'No')]
        [String]
        $EnableTls11 = 'Yes',

        # EnableTls12 help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('enable-tls-1-2')]
        [ValidateSet('Yes', 'No')]
        [String]
        $EnableTls12 = 'Yes',

        # EnableSslCompatibilityMode help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('enable-ssl-compatibility-mode')]
        [ValidateSet('Yes', 'No')]
        [String]
        $EnableSslCompatibilityMode = 'No',

        # ClientCertificate help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('client-certificate')]
        [ValidateNotNullOrEmpty()]
        [String]
        $ClientCertificate,

        # EnableHttps help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('enable-https')]
        [ValidateSet('Yes', 'No')]
        [String]
        $EnableHttps  = 'No',

        # ValidateCertificate help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('validate-certificate')]
        [ValidateSet('Yes', 'No')]
        [String]
        $ValidateCertificate  = 'Yes',

        # EnableTls1 help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('enable-tls-1')]
        [ValidateSet('Yes', 'No')]
        [String]
        $EnableTls1  = 'No'
    )

    process {
        try {
            $PSBoundParameters |
                ConvertTo-PostData |
                    Invoke-API -Path ('/restapi/v3/services/{0}/servers/{1}/ssl-policy' -f $WebApplicationName, $WebServerName) -Method Put
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