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
function Update-ServiceSslSecurity {
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

        # Ciphers help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('Default', 'Custom')]
        [String]
        $Ciphers = 'Default',

        # EnableSNI help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('Yes', 'No')]
        [Alias('enable-sni')]
        [String]
        $EnableSni = 'No',

        # Status help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('On', 'Off')]
        [String]
        $Status = 'Off',

        # Certificate help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $Certificate,

        # HstsMaxAge help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateRange(0, 365)]
        [Alias('hsts-max-age')]
        [Int]
        $HstsMaxAge = 365,

        # SniCertificate help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('sni-certificate')]
        [String[]]
        $SniCertificate,

        # EnableStrictSniCheck help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('Yes', 'No')]
        [Alias('enable-strict-sni-check')]
        [String]
        $EnableStrictSniCheck = 'No',

        # EcdsaCertificate help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('ecdsa-certificate')]
        [String]
        $EcdsaCertificate,

        # Domain help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [String[]]
        $Domain,

        # OverrideCiphersSsl3 help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('override-ciphers-ssl3')]
        [String]
        $OverrideCiphersSsl3,

        # OverrideCiphersTls1 help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('override-ciphers-tls-1')]
        [String]
        $OverrideCiphersTls1,

        # OverrideCiphersTls1 help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('override-ciphers-tls-1-1')]
        [String]
        $OverrideCiphersTls11,

        # EnableSsl3 help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('Yes', 'No')]
        [Alias('enable-ssl-3')]
        [String]
        $EnableSsl3 = 'No',

        # EnableTls11 help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('Yes', 'No')]
        [Alias('enable-tls-1-1')]
        [String]
        $EnableTls11 = 'Yes',

        # EnableHsts help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('Yes', 'No')]
        [Alias('enable-hsts')]
        [String]
        $EnableHsts = 'No',

        # EnableTls12 help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('Yes', 'No')]
        [Alias('enable-tls-1-2')]
        [String]
        $EnableTls12 = 'Yes',

        # IncludeHstsSubDomains help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('Yes', 'No')]
        [Alias('include-hsts-sub-domains')]
        [String]
        $IncludeHstsSubDomains = 'No',

        # SniEcdsaCertificate help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('sni-ecdsa-certificate')]
        [String[]]
        $SniEcdsaCertificate,

        # SelectedCiphers help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('selected-ciphers')]
        [String[]]
        $SelectedCiphers = @('ECDHE-ECDSA-AES256-GCM-SHA384', 'ECDHE-RSA-AES256-GCM-SHA384', 'ECDHE-ECDSA-AES128-GCM-SHA256', 'ECDHE-RSA-AES128-GCM-SHA256', 'ECDHE-ECDSA-AES256-SHA384', 'ECDHE-RSA-AES256-SHA384', 'ECDHE-ECDSA-AES128-SHA256', 'ECDHE-RSA-AES128-SHA256', 'AES256-GCM-SHA384', 'AES128-GCM-SHA256', 'AES256-SHA256', 'AES128-SHA256', 'ECDHE-ECDSA-AES256-SHA', 'ECDHE-RSA-AES256-SHA', 'ECDHE-ECDSA-DES-CBC3-SHA', 'ECDHE-RSA-DES-CBC3-SHA', 'ECDHE-ECDSA-AES128-SHA', 'ECDHE-RSA-AES128-SHA', 'AES256-SHA','DHE-RSA-AES256-GCM-SHA384', 'DHE-RSA-AES256-SHA256', 'DHE-RSA-AES256-SHA', 'DHE-RSA-CAMELLIA256-SHA', 'DHE-RSA-AES128-GCM-SHA256', 'DHE-RSA-AES128-SHA256', 'DHE-RSA-AES128-SHA', 'DHE-RSA-CAMELLIA128-SHA', 'EDH-RSA-DES-CBC3-SHA', 'CAMELLIA256-SHA', 'DES-CBC3-SHA', 'AES128-SHA', 'CAMELLIA128-SHA'),

        # EnablePfs help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('Yes', 'No')]
        [Alias('enable-pfs')]
        [String]
        $EnablePfs = 'No',

        # EnablePfs help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('Yes', 'No')]
        [Alias('enable-tls-1')]
        [String]
        $EnableTls1 = 'No'
    )

    process {
        try {
            $PSBoundParameters.Remove('WebApplicationName') | Out-Null

            if ($PSBoundParameters.ContainsKey('SelectedCiphers')) {
                $PSBoundParameters.SelectedCiphers = @($PSBoundParameters.SelectedCiphers -join ',')
            }

            $PSBoundParameters |
                ConvertTo-Post |
                    Invoke-API -Path ('/restapi/v3/services/{0}/ssl-security' -f $WebApplicationName) -Method Put
        } catch {
            if ($_.Exception -is [System.Net.WebException]) {
                Write-Verbose "ExceptionResponse: `n$($_ | Get-ExceptionResponse)`n"
            }
            throw
        }
    }
}