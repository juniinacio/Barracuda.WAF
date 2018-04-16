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
function New-RuleGroupServer {
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

        # BackupServer help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'IPAddress')]
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Hostname')]
        [Alias('backup-server')]
        [ValidateSet('Yes', 'No')]
        [String]
        $BackupServer = 'No',

        # AddressVersion help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'IPAddress')]
        [Alias('address-version')]
        [ValidateSet('IPv4', 'IPv6')]
        [String]
        $AddressVersion = 'IPv4',

        # Status help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'IPAddress')]
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Hostname')]
        [ValidateSet('In Service', 'Out of Service Maintenance', 'Out of Service Sticky', 'Out of Service All')]
        [String]
        $Status = 'In Service',

        # Name help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'IPAddress')]
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Hostname')]
        [ValidateLength(1, 255)] 
        [String]
        $Name,

        # Hostname help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Hostname')]
        [ValidateNotNullOrEmpty()]
        [String]
        $Hostname,

        # Port help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'IPAddress')]
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Hostname')]
        [ValidateRange(1, 65535)]
        [Int]
        $Port = 80,

        # Comments help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'IPAddress')]
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Hostname')]
        [ValidateNotNullOrEmpty()]
        [String]
        $Comments,

        # Weight help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'IPAddress')]
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Hostname')]
        [ValidateRange(1, 65535)]
        [Int]
        $Weight = 80,

        # IpAddress help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'IPAddress')]
        [Alias('ip-address')]
        [ValidateNotNullOrEmpty()]
        [String]
        $IpAddress
    )

    process {
        try {
            $PSBoundParameters.Remove('WebApplicationName') | Out-Null
            $PSBoundParameters.Remove('RuleGroupName') | Out-Null

            switch ($PSCmdlet.ParameterSetName) {
                'IPAddress' {
                    $PSBoundParameters.Identifier = 'IP Address'
                }

                'Hostname' {
                    $PSBoundParameters.Identifier = 'Hostname'
                }
            }

            $PSBoundParameters |
                ConvertTo-Post |
                    Invoke-API -Path ('/restapi/v3/services/{0}/content-rules/{1}/content-rule-servers' -f $WebApplicationName, $RuleGroupName) -Method Post
        } catch {
            if ($_.Exception -is [System.Net.WebException]) {
                Write-Verbose "ExceptionResponse: `n$($_ | Get-ExceptionResponse)`n"
            }
            throw
        }
    }
}