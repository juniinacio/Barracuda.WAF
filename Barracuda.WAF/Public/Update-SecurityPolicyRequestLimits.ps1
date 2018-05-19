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
function Update-SecurityPolicyRequestLimits {
    [CmdletBinding()]
    [Alias()]
    [OutputType([PSCustomObject])]
    Param (
        # PolicyName help description
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]        
        [String]
        $PolicyName,

        # MaxNumberOfCookies help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('max-number-of-cookies')]
        [Int]
        $MaxNumberOfCookies,

        # MaxHeaderNameLength help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('max-header-name-length')]
        [Int]
        $MaxHeaderNameLength,

        # Enable help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('Yes', 'No')]
        [String]
        $Enable = 'Yes',

        # MaxRequestLength help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('max-request-length')]
        [Int]
        $MaxRequestLength,

        # MaxNumberOfHeaders help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('max-number-of-headers')]
        [Int]
        $MaxNumberOfHeaders,

        # NaxCookieValueLength help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('max-cookie-value-length')]
        [Int]
        $MaxCookieValueLength,

        # MaxQueryLength help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('max-query-length')]
        [Int]
        $MaxQueryLength,

        # MaxUrlLength help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('max-url-length')]
        [Int]
        $MaxUrlLength,

        # MaxRequestLineLength help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('max-request-line-length')]
        [Int]
        $MaxRequestLineLength,

        # MaxHeaderValueLength help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('max-header-value-length')]
        [Int]
        $MaxHeaderValueLength,

        # MaxCookieNameLength help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('max-cookie-name-length')]
        [Int]
        $MaxCookieNameLength
    )

    process {
        try {
            $PSBoundParameters.Remove('PolicyName') | Out-Null

            $PSBoundParameters.name = $NewName

            $PSBoundParameters |
                ConvertTo-Post |
                    Invoke-API -Path ('/restapi/v3/security-policies/{0}/request-limits' -f $PolicyName) -Method Put
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