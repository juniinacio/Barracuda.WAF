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
function Update-SecurityPolicyCookieSecurity {
    [CmdletBinding()]
    [Alias()]
    [OutputType([PSCustomObject])]
    Param (
        # PolicyName help description
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]        
        [String]
        $PolicyName,

        # CookieReplayProtectionType help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('None', 'IP', 'Custom Headers', 'IP and Custom Headers')]
        [Alias('cookie-replay-protection-type')]
        [String]
        $CookieReplayProtectionType = 'IP',

        # CustomHeaders help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('custom-headers')]
        [String[]]
        $CustomHeaders,

        # SecureCookie help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('Yes', 'No')]
        [Alias('secure-cookie')]
        [String]
        $SecureCookie = 'No',

        # HttpOnly help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('Yes', 'No')]
        [Alias('http-only')]
        [String]
        $HttpOnly = 'No',

        # TamperProofMode help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('Encrypted', 'Signed', 'None')]
        [Alias('tamper-proof-mode')]
        [String]
        $TamperProofMode,

        # CookieMaxAge help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateRange(0, 500000)]
        [Alias('cookie-max-age')]
        [Int]
        $CookieMaxAge = 1440,

        # CookiesExempted help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('cookies-exempted')]
        [String[]]
        $CookiesExempted,

        # AllowUnrecognizedCookies help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('Never', 'Always', 'Custom')]
        [Alias('allow-unrecognized-cookies')]
        [String]
        $AllowUnrecognizedCookies,

        # DaysAllowed help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('days-allowed')]
        [Int]
        $DaysAllowed = 7
    )

    process {
        try {
            $PSBoundParameters.Remove('PolicyName') | Out-Null

            $PSBoundParameters |
                ConvertTo-Post |
                    Invoke-API -Path ('/restapi/v3/security-policies/{0}/cookie-security' -f $PolicyName) -Method Put
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