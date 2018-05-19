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
function Update-ServiceBasicSecurity {
    [CmdletBinding()]
    [Alias()]
    [OutputType([PSCustomObject])]
    Param (
        # WebApplicationName help description
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [ValidateLength(1, 64)]
        [String]
        $WebApplicationName,

        # RateControlStatus help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('rate-control-status')]
        [ValidateSet('On', 'Off')]
        [String]
        $RateControlStatus = 'Off',

        # RateControlPool help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('rate-control-pool')]
        [String]
        $RateControlPool = 'NONE',

        # WebFirewallLogLevel help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('web-firewall-log-level')]
        [ValidateSet('0-Emergency', '1-Alert', '2-Critical', '3-Error', '4-Warning', '5-Notice', '6-Information', '7-Debug')]
        [String]
        $WebFirewallLogLevel = '5-Notice',

        # TrustedHostsGroup help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('trusted-hosts-group')]
        [ValidateNotNullOrEmpty()]
        [String]
        $TrustedHostsGroup,

        # HstsMaxAge help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('Passive', 'Active')]
        [String]
        $Mode = 'Passive',

        # ClientIpAddrHeader help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('client-ip-addr-header')]
        [String]
        $ClientIpAddrHeader,

        # IgnoreCase help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('Yes', 'No')]
        [Alias('ignore-case')]
        [String]
        $IgnoreCase = 'Yes',

        # TrustedHostsAction help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('Allow', 'Passive', 'Default')]
        [Alias('trusted-hosts-action')]
        [String]
        $TrustedHostsAction = 'Default',

        # WebFirewallPolicy help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('web-firewall-policy')]
        [String]
        $WebFirewallPolicy = 'default'
    )

    process {
        try {
            $PSBoundParameters.Remove('WebApplicationName') | Out-Null

            $PSBoundParameters |
                ConvertTo-Post |
                    Invoke-API -Path ('/restapi/v3/services/{0}/basic-security' -f $WebApplicationName) -Method Put
        } catch {
            if ($_.Exception -is [System.Net.WebException]) {
                Write-Verbose "ExceptionResponse: `n$($_ | Get-ExceptionResponse)`n"
            }
            throw
        }
    }
}