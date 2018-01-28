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
function Update-Server {
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
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [ValidateLength(1, 255)]
        [String]
        $ServerName,

        # AddressVersion help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'IPAddress')]
        [ValidateSet('IPv4', 'IPv6')]
        [Alias('address-version')]
        [String]
        $AddressVersion = 'IPv4',

        # AddressVersion help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'IPAddress')]
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Hostname')]
        [ValidateSet('In Service', 'Out of Service Maintenance', 'Out of Service Sticky', 'Out of Service All')]
        [String]
        $Status = 'In Service',

        # NewServerName help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'IPAddress')]
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Hostname')]
        [ValidateNotNullOrEmpty()]
        [ValidateLength(1, 255)]
        [Alias('name')]
        [String]
        $NewServerName,

        # IPAddress help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'IPAddress')]
        [ValidateNotNullOrEmpty()]
        [Alias('ip-address')]
        [String]
        $IpAddress,

        # Hostname help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Hostname')]
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
        $Comments = 'Comments'
    )

    process {
        try {
            $PSBoundParameters.Remove('WebApplicationName') | Out-Null
            $PSBoundParameters.Remove('ServerName') | Out-Null

            if ($PSBoundParameters.ContainsKey('NewServerName')) {
                $PSBoundParameters['Name'] = $NewServerName

                $PSBoundParameters.Remove('NewServerName') | Out-Null
            } else {
                $PSBoundParameters['Name'] = $ServerName
            }

            switch ($PSCmdlet.ParameterSetName) {
                'IPAddress' {
                    $PSBoundParameters.Identifier = 'IP Address'
                }

                'Hostname' {
                    $PSBoundParameters.Identifier = 'Hostname'
                }
            }

            $PSBoundParameters |
                ConvertTo-PostData |
                    Invoke-API -Path ('/restapi/v3/services/{0}/servers/{1}' -f $WebApplicationName, $ServerName) -Method Put
        } catch {
            if ($_.Exception -is [System.Net.WebException]) {
                Write-Verbose "ExceptionResponse: `n$($_ | Get-ExceptionResponse)`n"
            }
            throw
        }
    }
}