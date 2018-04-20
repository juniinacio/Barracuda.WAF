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
function Update-RuleGroupServerApplicationLayerHealthCheck {
    [CmdletBinding()]
    [Alias()]
    [OutputType([PSCustomObject])]
    Param (
        # WebApplicationName help description
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]        
        [String]
        $WebApplicationName,

        # RuleGroupName help description
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]        
        [String]
        $RuleGroupName,

        # WebServerName help description
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]        
        [String]
        $WebServerName,

        # Domain help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $Domain,

        # MatchContentString help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateLength(1, 255)]
        [Alias('match-content-string')]
        [String]
        $MatchContentString,

        # Url help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateLength(1, 950)]
        [String]
        $Url,

        # AdditionalHeaders help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('additional-headers')]
        [ValidateNotNullOrEmpty()]
        [String[]]
        $AdditionalHeaders,

        # Method help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('GET', 'HEAD', 'POST')]
        [String]
        $Method = 'GET',

        # StatusCode help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateRange(100, 999)]
        [Alias('status-code')]
        [Int]
        $StatusCode = 200
    )

    process {
        try {
            $PSBoundParameters.Remove('WebApplicationName') | Out-Null
            $PSBoundParameters.Remove('WebServerName') | Out-Null
            $PSBoundParameters.Remove('RuleGroupName') | Out-Null

            $PSBoundParameters |
                ConvertTo-Post |
                    Invoke-API -Path ('/restapi/v3/services/{0}/content-rules/{1}/content-rule-servers/{2}/application-layer-health-checks' -f $WebApplicationName, $RuleGroupName, $WebServerName) -Method Put
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