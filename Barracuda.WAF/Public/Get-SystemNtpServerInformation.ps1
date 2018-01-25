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
function Get-SystemNtpServerInformation {
    [CmdletBinding()]
    [Alias()]
    [OutputType([PSCustomObject])]
    Param (
        # SystemNTPServerName help description
        [Parameter(Mandatory = $false, ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [String[]]
        $SystemNTPServerName,

        # Parameters help description
        [Parameter(Mandatory = $false)]
        [ValidateSet('description', 'ip-address', 'name')]
        [String[]]
        $Parameters
    )

    process {
        try {
            $params = @{}
            
            if ($PSBoundParameters.ContainsKey('Parameters')) {
                $params.parameters = $Parameters -join ','
            }

            if ($PSBoundParameters.ContainsKey('SystemNTPServerName')) {
                foreach ($name in $SystemNTPServerName) {
                    Invoke-API -Path ('/restapi/v3/system/ntp-servers/{0}' -f $name) -Method Get -Parameters $params
                }
            } else {
                Invoke-API -Path '/restapi/v3/system/ntp-servers' -Method Get -Parameters $params
            }
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