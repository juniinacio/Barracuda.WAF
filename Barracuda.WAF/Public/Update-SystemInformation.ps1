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
function Update-SystemInformation {
    [CmdletBinding()]
    [Alias()]
    [OutputType([PSCustomObject])]
    Param (
        # OperationMode help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('operation-mode')]
        [ValidateNotNullOrEmpty()]
        [String]
        $OperationMode = 'proxy',

        # DeviceName help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('device-name')]
        [ValidateNotNullOrEmpty()]
        [String]
        $DeviceName,

        # Serial help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [Int]
        $Serial,

        # Model help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $Model,

        # Locale help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $Locale = 'en_US',

        # Hostname help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateLength(1, 512)]
        [String]
        $Hostname = 'barracuda',

        # Domain help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateLength(1, 512)]
        [String]
        $Domain,

        # Timezone help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('time-zone')]
        [ValidateNotNullOrEmpty()]
        [String]
        $TimeZone,

        # EnableIpv6 help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('enable-ipv6')]
        [ValidateSet('Yes', 'No')]
        [String]
        $EnableIpv6 = 'No',

        # InterfaceForSystemServices help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('interface-for-system-services')]
        [ValidateSet('WAN', 'Management')]
        [String]
        $InterfaceForSystemServices = 'WAN'
    )

    process {
        try {
            $PSBoundParameters |
                ConvertTo-PostData |
                    Invoke-API -Path '/restapi/v3/system' -Method Put
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