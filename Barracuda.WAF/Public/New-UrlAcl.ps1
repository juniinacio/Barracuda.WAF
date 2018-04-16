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
function New-UrlAcl {
    [CmdletBinding()]
    [Alias()]
    [OutputType([PSCustomObject])]
    Param (
        # WebApplicationName help description
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]        
        [String]
        $WebApplicationName,

        # ResponsePage help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('response-page')]
        [ValidateNotNullOrEmpty()]
        [String]
        $ResponsePage,

        # ExtendedMatchSequence help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('extended-match-sequence')]
        [ValidateRange(1, 1000)]
        [Int]
        $ExtendedMatchSequence = 1,

        # Enable help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('On', 'Off')]
        [String]
        $Enable = 'On',

        # RedirectUrl help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('redirect-url')]
        [ValidateLength(1, 1024)]
        [String]
        $RedirectUrl,

        # DenyResponse help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('deny-response')]
        [ValidateSet('Reset', 'Response Page', 'Temporary Redirect', 'Permanent Redirect')]
        [String]
        $DenyResponse,

        # Name help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateLength(1, 64)]
        [String]
        $Name,

        # ExtendedMatch help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('extended-match')]
        [ValidateLength(1, 4096)]
        [String]
        $ExtendedMatch = '*',

        # FollowUpAction help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('follow-up-action')]
        [ValidateSet('None', 'Block Client-IP', 'Challenge with CAPTCHA')]
        [String]
        $FollowUpAction,

        # Comments help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateLength(1, 256)]
        [String]
        $Comments,

        # HostMatch help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('host')]
        [ValidateLength(1, 128)]
        [String]
        $HostMatch = '*',

        # FollowUpActionTime help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('follow-up-action-time')]
        [ValidateRange(1, 600000)]
        [Int]
        $FollowUpActionTime = 60,

        # Url help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateLength(1, 5000)]
        [String]
        $Url = '/*',

        # Action help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('Process', 'Allow', 'Allow and Log', 'Deny and Log', 'Deny with no Log', 'Temporary Redirect', 'Permanent Redirect')]
        [String]
        $Action
    )

    process {
        try {
            $PSBoundParameters.Remove('WebApplicationName') | Out-Null

            if ($PSBoundParameters.ContainsKey('HostMatch')) {
                $PSBoundParameters.host = $HostMatch
                $PSBoundParameters.Remove('HostMatch') | Out-Null
            }

            $PSBoundParameters |
                ConvertTo-Post |
                    Invoke-API -Path ('/restapi/v3/services/{0}/url-acls' -f $WebApplicationName) -Method Post
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