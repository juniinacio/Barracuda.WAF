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
    https://campus.barracuda.com/product/webapplicationfirewall/article/WAF/RESTAPICert/
#>
function Get-Certificate {
    [CmdletBinding(DefaultParameterSetName='Fetch information of certificates')]
    [Alias()]
    [OutputType([PSCustomObject])]
    Param (
        # CertificateName help description
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Fetch information of a certificate')]
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Download information of certificates')]
        [ValidateNotNullOrEmpty()]        
        [String[]]
        $CertificateName,

        # Download help description
        [Parameter(Mandatory = $true, ParameterSetName = 'Download information of certificates')]
        [ValidateSet('CSR', 'PEM', 'PKCS')]        
        [String]
        $Download,

        # Password help description
        [Parameter(Mandatory = $true, ParameterSetName = 'Download information of certificates')]
        [ValidateNotNullOrEmpty()]        
        [SecureString]
        $Password
    )

    process {
        if ($PSBoundParameters.ContainsKey('CertificateName')) {
            foreach ($name in $CertificateName) {
                try {
                    $parameters = @{}

                    if ($PSCmdlet.ParameterSetName -eq 'Download information of certificates') {
                        $parameters.download = $Download

                        $bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($Password)

                        $parameters.password = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)
                    }

                    Invoke-API -Path $('/restapi/v3/certificates/{0}' -f $name) -Parameters $parameters

                } catch {
                    if ($_.Exception -is [System.Net.WebException]) {
                        if ($_.Exception.Response.StatusCode -ne 404) {
                            throw
                        }
                    } else {
                        throw
                    }
                }
            }
        } else {
            Invoke-API -Path '/restapi/v3/certificates'
        }
    }
}