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
function Update-Service {
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

        # Status help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('On', 'Off')]
        [String]
        $Status = 'On',

        # ServiceId help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('service-id')]
        [String]
        $ServiceId,

        # Comments help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $Comments = 'Comments',

        # EnableAccessLogs help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('Yes', 'No')]
        [Alias('enable-access-logs')]
        [String]
        $EnableAccessLogs = 'Yes',

        # SessionTimeout help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateRange(0, 86400)]
        [Alias('session-timeout')]
        [Int]
        $SessionTimeout = 60,

        # AppId help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('app-id')]
        [String]
        $AppId,

        # Group help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [ValidateLength(1, 64)]
        [String]
        $Group,

        # VSite help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [ValidateLength(1, 64)]
        [String]
        $VSite,

        # IPAddress help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('ip-address')]
        [String]
        $IpAddress,

        # Mask help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $Mask,

        # AddressVersion help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('IPv4', 'IPv6')]
        [Alias('address-version')]
        [String]
        $AddressVersion = 'IPv4',

        # NewWebApplicationName help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [ValidateLength(1, 64)]
        [Alias('name')]
        [String]
        $NewWebApplicationName,

        # Port help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateRange(1, 65535)]
        [Int]
        $Port = 80,

        # DpsEnabled help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('Yes', 'No')]
        [Alias('dps-enabled')]
        [String]
        $DpsEnabled = 'No',

        # Type help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('HTTP', 'HTTPS', 'Instant SSL', 'Redirect Service', 'Custom', 'Custom SSL', 'FTP', 'FTP SSL')]
        [String]
        $Type = 'HTTP',

        # AzureIpSelect help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('azure-ip-select')]
        [String]
        $AzureIpSelect,

        # LinkedServiceName help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('linked-service-name')]
        [String]
        $LinkedServiceName
    )

    DynamicParam {
        if (@('HTTPS', 'Instant SSL', 'Custom SSL', 'FTP SSL') -contains $Type) {
            $certificateAttribute = New-Object -TypeName 'System.Management.Automation.ParameterAttribute'
            $certificateAttribute.Mandatory = $true
            $certificateAttribute.HelpMessage = "Please enter certificate name:"

            $attributeCollection = New-Object -TypeName 'System.Collections.ObjectModel.Collection[System.Attribute]'
            $attributeCollection.Add($certificateAttribute)

            $certificateParameter = New-Object 'System.Management.Automation.RuntimeDefinedParameter' -ArgumentList ('Certificate', [String], $attributeCollection)

            $parameterDictionary = New-Object -TypeName 'System.Management.Automation.RuntimeDefinedParameterDictionary'
            $parameterDictionary.Add('Certificate', $certificateParameter)

            if ($Type -eq 'Instant SSL') {
                $secureSiteDomainAttribute = New-Object -TypeName 'System.Management.Automation.ParameterAttribute'
                $secureSiteDomainAttribute.Mandatory = $true
                $secureSiteDomainAttribute.HelpMessage = "Please enter domain name:"

                $attributeCollection = New-Object -TypeName 'System.Collections.ObjectModel.Collection[System.Attribute]'
                $attributeCollection.Add($secureSiteDomainAttribute)

                $secureSiteDomainParameter = New-Object 'System.Management.Automation.RuntimeDefinedParameter' -ArgumentList ('SecureSiteDomain', [String], $attributeCollection)

                $parameterDictionary.Add('SecureSiteDomain', $secureSiteDomainParameter)
            }

            return $parameterDictionary
        }
    }

    process {
        try {
            $PSBoundParameters.Remove('WebApplicationName') | Out-Null

            if ($PSBoundParameters.ContainsKey('NewWebApplicationName')) {
                $PSBoundParameters['Name'] = $NewWebApplicationName
                $PSBoundParameters.Remove('NewWebApplicationName') | Out-Null
            }

            $PSBoundParameters |
                ConvertTo-Post |
                    Invoke-API -Path ('/restapi/v3/services/{0}' -f $WebApplicationName) -Method Put 
        } catch {
            if ($_.Exception -is [System.Net.WebException]) {
                Write-Verbose "ExceptionResponse: `n$($_ | Get-ExceptionResponse)`n"
            }
            throw
        }
    }
}