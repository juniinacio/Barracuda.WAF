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
function Update-UrlProfile {
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
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]        
        [String]
        $URLProfileName,

        # ExtendedMatchSequence help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('extended-match-sequence')]
        [ValidateRange(0, 1000)]
        [Int]
        $ExtendedMatchSequence = 1,

        # HiddenParameterProtection help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('hidden-parameter-protection')]
        [ValidateSet('None', 'Forms', 'Forms and URLs')]
        [String]
        $HiddenParameterProtection = 'Forms',

        # Status help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('On', 'Off')]
        [String]
        $Status = 'On',

        # Mode help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('Learning', 'Passive', 'Active')]
        [String]
        $Mode = 'Passive',

        # ExceptionPatterns help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('exception-patterns')]
        [ValidateNotNullOrEmpty()]
        [String]
        $ExceptionPatterns,

        # ExtendedMatch help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('extended-match')]
        [ValidateLength(1, 4096)]
        [String]
        $ExtendedMatch = '*',

        # AllowedMethods help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('allowed-methods')]
        [ValidateNotNullOrEmpty()]
        [String]
        $AllowedMethods,

        # DisplayName help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('display-name')]
        [ValidateLength(1, 64)]
        [String]
        $DisplayName,

        # Url help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateLength(1, 5000)]
        [String]
        $Url,

        # AllowedContentTypes help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('allowed-content-types')]
        [ValidateNotNullOrEmpty()]
        [String]
        $AllowedContentTypes,

        # MaxContentLength help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('max-content-length')]
        [ValidateRange(0, 1073741824)]
        [Int]
        $MaxContentLength = 32768,

        # NewName help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('name')]
        [ValidateLength(1, 64)]
        [String]
        $NewName,

        # CustomBlockedAttackTypes help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('custom-blocked-attack-types')]
        [ValidateNotNullOrEmpty()]
        [String]
        $CustomBlockedAttackTypes,

        # AllowQueryString help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('allow-query-string')]
        [ValidateSet('No', 'Yes')]
        [String]
        $AllowQueryString = 'Yes',

        # CsrfPrevention help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('csrf-prevention')]
        [ValidateSet('None', 'Forms', 'Forms and URLs')]
        [String]
        $CsrfPrevention = 'None',

        # ReferrersForTheUrlProfile help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('referrers-for-the-url-profile')]
        [ValidateNotNullOrEmpty()]
        [String]
        $ReferrersForTheUrlProfile,

        # BlockedAttackTypes help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('blocked-attack-types')]
        [ValidateNotNullOrEmpty()]
        [String]
        $BlockedAttackTypes,

        # Comment help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateLength(1, 256)]
        [String]
        $Comment,

        # MaximumUploadFiles help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('maximum-upload-files')]
        [ValidateRange(0, 1024)]
        [Int]
        $MaximumUploadFiles = 5,

        # MaximumParameterNameLength help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('maximum-parameter-name-length')]
        [ValidateRange(0, 1024)]
        [Int]
        $MaximumParameterNameLength = 64
    )

    process {
        try {
            $PSBoundParameters.Remove('WebApplicationName') | Out-Null
            $PSBoundParameters.Remove('URLProfileName') | Out-Null

            $PSBoundParameters.name = $URLProfileName

            if ($PSBoundParameters.ContainsKey('NewName')) {
                $PSBoundParameters.name = $NewName
                $PSBoundParameters.Remove('NewName') | Out-Null
            }

            $PSBoundParameters |
                ConvertTo-PostData |
                    Invoke-API -Path ('/restapi/v3/services/{0}/url-profiles/{1}' -f $WebApplicationName, $URLProfileName) -Method Put
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