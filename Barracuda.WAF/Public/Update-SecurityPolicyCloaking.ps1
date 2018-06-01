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
function Update-SecurityPolicyCloaking {
    [CmdletBinding()]
    [Alias()]
    [OutputType([PSCustomObject])]
    Param (
        # PolicyName help description
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]        
        [String]
        $PolicyName,

        # FilterResponseHeader help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('Yes', 'No')]
        [Alias('filter-response-header')]
        [String]
        $FilterResponseHeader = "Yes",

        # ReturnCodesToExempt help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('return-codes-to-exempt')]
        [String[]]
        $ReturnCodesToExempt,

        # HeadersToFilter help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('headers-to-filter')]
        [String[]]
        $HeadersToFilter,

        # SuppressReturnCode help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('Yes', 'No')]
        [Alias('suppress-return-code')]
        [String]
        $SuppressReturnCode = 'Yes'
    )

    process {
        try {
            $PSBoundParameters.Remove('PolicyName') | Out-Null

            $PSBoundParameters |
                ConvertTo-Post |
                    Invoke-API -Path ('/restapi/v3/security-policies/{0}/cloaking' -f $PolicyName) -Method Put
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