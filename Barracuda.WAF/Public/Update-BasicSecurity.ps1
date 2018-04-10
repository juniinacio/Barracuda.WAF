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
function Update-BasicSecurity {
    [CmdletBinding()]
    [Alias()]
    [OutputType([PSCustomObject])]
    Param (
        # WebApplicationName help description
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]        
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
        [ValidateSet('0-Emergency', '1-Alert', '2-Critical', '3-Error', '4-Warning', '5-Notice', '6-Information', '7-Debug')]
        [Alias('web-firewall-log-level')]
        [String]
        $WebFirewallLogLevel = '5-Notice',

        # TrustedHostsGroup help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('trusted-hosts-group')]
        [String]
        $TrustedHostsGroup,

        # Mode help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('Passive', 'Active')]
        [String]
        $Mode = 'Passive',

        # ClientIpAddrHeader help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('client-ip-addr-header')]
        [ValidateLength(1, 50)]
        [String]
        $ClientIpAddrHeader,

        # IgnoreCase help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('ignore-case')]
        [ValidateSet('Yes', 'No')]
        [String]
        $IgnoreCase = 'Yes',

        # TrustedHostsAction help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('trusted-hosts-action')]
        [ValidateSet('Allow', 'Passive', 'Default')]
        [String]
        $TrustedHostsAction = 'Default',

        # WebFirewallPolicy help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('web-firewall-policy')]
        [ValidateNotNullOrEmpty()]
        [String]
        $WebFirewallPolicy = 'default'
    )

    process {
        try {
            $PSBoundParameters.Remove('WebApplicationName') | Out-Null

            $PSBoundParameters |
                ConvertTo-PostData |
                    Invoke-API -Path ('/restapi/v3/services/{0}/basic-security' -f $WebApplicationName) -Method Put
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