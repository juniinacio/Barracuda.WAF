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
function Update-RuleGroup {
    [CmdletBinding()]
    [Alias()]
    [OutputType([PSCustomObject])]
    Param (
        # WebApplicationName help description
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]        
        [String]
        $WebApplicationName,

        # ExtendedMatchSequence help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('extended-match-sequence')]
        [ValidateRange(0, 1000)]
        [Int]
        $ExtendedMatchSequence = 1000,

        # AccessLog help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('access-log')]
        [ValidateSet('Enable', 'Disable')]
        [String]
        $AccessLog = 'Enable',

        # UrlMatch help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Alias('url-match')]
        [ValidateNotNullOrEmpty()]
        [String]
        $UrlMatch,

        # Status help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('On', 'Off')]
        [String]
        $Status = 'On',

        # Mode help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('Passive', 'Active')]
        [String]
        $Mode = 'Passive',

        # RuleGroupName help description
        [Parameter(Mandatory = $true)]
        [ValidateLength(1, 64)]
        [String]
        $RuleGroupName,

        # NewRuleGroupName help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateLength(1, 64)]
        [Alias('name')] 
        [String]
        $NewRuleGroupName,

        # ExtendedMatch help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateLength(1, 4096)]
        [Alias('extended-match')]      
        [String]
        $ExtendedMatch,

        # Comments help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]        
        [String]
        $Comments,

        # WebFirewallPolicy help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('web-firewall-policy')]
        [ValidateNotNullOrEmpty()]        
        [String]
        $WebFirewallPolicy,

        # AppId help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('app-id')]
        [ValidateNotNullOrEmpty()]        
        [String]
        $AppId,

        # HostMatch help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Alias('host-match')]
        [ValidateNotNullOrEmpty()]        
        [String]
        $HostMatch
    )

    process {
        try {
            $PSBoundParameters['Name'] = $RuleGroupName
            $PSBoundParameters.Remove('RuleGroupName') | Out-Null

            if ($PSBoundParameters.ContainsKey('NewRuleGroupName')) {
                $PSBoundParameters['Name'] = $NewRuleGroupName
                $PSBoundParameters.Remove('NewRuleGroupName') | Out-Null
            }

            $PSBoundParameters |
                ConvertTo-PostData |
                    Invoke-API -Path ('/restapi/v3/services/{0}/content-rules/{1}' -f $WebApplicationName, $RuleGroupName) -Method Put
        } catch {
            if ($_.Exception -is [System.Net.WebException]) {
                Write-Verbose "ExceptionResponse: `n$($_ | Get-ExceptionResponse)`n"
            }
            throw
        }
    }
}