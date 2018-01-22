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
function New-Server {
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

        # ServerName help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [ValidateLength(1, 255)]
        [Alias('name')]
        [String]
        $ServerName,

        # Identifier help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('IP Address', 'Hostname')]
        [String]
        $Identifier = 'IP Address',

        # AddressVersion help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('IPv4', 'IPv6')]
        [Alias('address-version')]
        [String]
        $AddressVersion = 'IPv4',

        # AddressVersion help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('In Service', 'Out of Service Maintenance', 'Out of Service Sticky', 'Out of Service All')]
        [String]
        $Status = 'In Service',

        # IPAddress help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('ip-address')]
        [String]
        $IpAddress,

        # Hostname help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $Hostname,

        # Port help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateRange(1, 65535)]
        [Int]
        $Port = 80,

        # Comments help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $Comments = 'Comments'
    )

    process {
        $PSBoundParameters.Remove('WebApplicationName')
        $PSBoundParameters.Remove('ServerName')

        $PSBoundParameters['Name'] = $ServerName

        $PSBoundParameters |
            ConvertTo-PostData |
                Invoke-API -Path ('/restapi/v3/services/{0}/servers' -f $WebApplicationName) -Method Post
    }
}