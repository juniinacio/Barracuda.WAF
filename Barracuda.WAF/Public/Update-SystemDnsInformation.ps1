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
function Update-SystemDnsInformation {
    [CmdletBinding()]
    [Alias()]
    [OutputType([PSCustomObject])]
    Param (
        # PrimaryDnsServer help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Alias('primary-dns-server')]
        [ValidateNotNullOrEmpty()]
        [String]
        $PrimaryDnsServer,

        # SecondaryDnsServer help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('secondary-dns-server')]
        [ValidateNotNullOrEmpty()]
        [String]
        $SecondaryDnsServer
    )

    process {
        try {
            $PSBoundParameters |
                ConvertTo-PostData |
                    Invoke-API -Path '/restapi/v3/system/dns' -Method Put
        } catch {
            if ($_.Exception -is [System.Net.WebException]) {
                Write-Verbose "ExceptionResponse: `n$($_ | Get-ExceptionResponse)`n"
            }
            throw
        }
    }
}