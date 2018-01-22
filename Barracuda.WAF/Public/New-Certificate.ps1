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
function New-Certificate {
    [CmdletBinding(DefaultParameterSetName = 'Upload Information of Trusted Server Certificates')]
    [Alias()]
    [OutputType([PSCustomObject])]
    Param (
        # AllowPrivateKeyExport help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Add Information of Certificates')]
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Upload Information of Signed Certificates')]
        [Alias('allow_private_key_export')]
        [ValidateSet('Yes', 'No')]
        [String]
        $AllowPrivateKeyExport,

        # City help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Add Information of Certificates')]
        [ValidateNotNullOrEmpty()]
        [String]
        $City,

        # CommonName help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Add Information of Certificates')]
        [Alias('common_name')]
        [ValidateNotNullOrEmpty()]
        [String]
        $CommonName,

        # CountryCode help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Add Information of Certificates')]
        [Alias('country_code')]
        [ValidateNotNullOrEmpty()]
        [String]
        $CountryCode,

        # CurveType help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Add Information of Certificates')]
        [Alias('curve_type')]
        [ValidateSet('secp256r1', 'secp384r1', 'secp512r1')]
        [String]
        $CurveType,

        # KeySize help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Add Information of Certificates')]
        [Alias('key_size')]
        [ValidateSet('1024', '2048', '4096')]
        [String]
        $KeySize,

        # Name help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Upload Information of Trusted Server Certificates')]
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Upload Information of Trusted CA Certificates')]
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Upload Information of Signed Certificates')]
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Add Information of Certificates')]
        [ValidateNotNullOrEmpty()]
        [String]
        $Name,

        # TrustedServerCertificateFilePath help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $false, ParameterSetName = 'Upload Information of Trusted Server Certificates')]
        [ValidateScript({Test-Path -Path $_ -PathType Leaf})]
        [ValidateNotNullOrEmpty()]
        [String]
        $TrustedServerCertificateFilePath,

        # TrustedCACertificateFilePath help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $false, ParameterSetName = 'Upload Information of Trusted CA Certificates')]
        [ValidateScript({Test-Path -Path $_ -PathType Leaf})]
        [ValidateNotNullOrEmpty()]
        [String]
        $TrustedCACertificateFilePath,

        # OrganizationName help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Add Information of Certificates')]
        [Alias('organization_name')]
        [ValidateNotNullOrEmpty()]
        [String]
        $OrganizationName,

        # OrganizationUnit help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Add Information of Certificates')]
        [Alias('organization_unit')]
        [ValidateNotNullOrEmpty()]
        [String]
        $OrganizationUnit,

        # SANCertificate help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Add Information of Certificates')]
        [Alias('san_certificate')]
        [ValidateNotNullOrEmpty()]
        [String[]]
        $SANCertificate,

        # State help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Add Information of Certificates')]
        [ValidateNotNullOrEmpty()]
        [String]
        $State,

        # Type help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Upload Information of Signed Certificates')]
        [ValidateSet('pkcs12', 'pem')]
        [String]
        $Type,

        # KeyType help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Upload Information of Signed Certificates')]
        [Alias('key_type')]
        [ValidateSet('rsa', 'ecdsa')]
        [String]
        $KeyType,

        # SignedCertificateFilePath help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $false, ParameterSetName = 'Upload Information of Signed Certificates')]
        [Alias('signed_certificate')]
        [ValidateScript({Test-Path -Path $_ -PathType Leaf})]
        [ValidateNotNullOrEmpty()]
        [String]
        $SignedCertificateFilePath,

        # AssignAssociatedKey help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Upload Information of Signed Certificates')]
        [Alias('assign_associated_key')]
        [ValidateSet('yes', 'no')]
        [String]
        $AssignAssociatedKey,

        # KeyFilePath help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $false, ParameterSetName = 'Upload Information of Signed Certificates')]
        [ValidateScript({Test-Path -Path $_ -PathType Leaf})]
        [ValidateNotNullOrEmpty()]
        [String]
        $KeyFilePath,

        # IntermediaryCertificateFilePath help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $false, ParameterSetName = 'Upload Information of Signed Certificates')]
        [Alias('intermediary_certificate')]
        [ValidateScript({Test-Path -Path $_ -PathType Leaf})]
        [ValidateNotNullOrEmpty()]
        [String]
        $IntermediaryCertificateFilePath,

        # Password help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Upload Information of Signed Certificates')]
        [ValidateNotNullOrEmpty()]        
        [SecureString]
        $Password
    )
    
    process {
        $parameters = @{}
        
        $headers = @{}

        switch ($PSCmdlet.ParameterSetName) {
            'Upload Information of Trusted Server Certificates' {
                $boundary = [System.Guid]::NewGuid().ToString()

                $headers.'Content-Type' = 'multipart/form-data; boundary="{0}"' -f $boundary

                $parameters.upload = 'trusted_server'
                
                $allBytes = [System.Io.File]::ReadAllBytes($TrustedServerCertificateFilePath)

                $contents = ([System.Text.Encoding]::GetEncoding("iso-8859-1")).GetString($allBytes)

                $postData = @'
--{0}
Content-Disposition: form-data; name="{1}" 

{2}
--{0}
Content-Disposition: form-data; name="{3}"; filename="{4}"

{5}
--{0}
'@              -f $boundary, 'name', $Name, 'trusted_server_certificate', $(Split-Path -Path $TrustedServerCertificateFilePath -Leaf),  $contents
            }

            'Add Information of Certificates' {
                $postData = $PSBoundParameters | ConvertTo-PostData -ConcatChar '_'
            }

            'Upload Information of Trusted CA Certificates' {
                $boundary = [System.Guid]::NewGuid().ToString()

                $headers.'Content-Type' = 'multipart/form-data; boundary="{0}"' -f $boundary

                $parameters.upload = 'trusted'
                
                $allBytes = [System.Io.File]::ReadAllBytes($TrustedCACertificateFilePath)

                $contents = ([System.Text.Encoding]::GetEncoding("iso-8859-1")).GetString($allBytes)

                $postData = @'
--{0}
Content-Disposition: form-data; name="{1}" 

{2}
--{0}
Content-Disposition: form-data; name="{3}"; filename="{4}"

{5}
--{0}
'@              -f $boundary, 'name', $Name, 'trusted_certificate', $(Split-Path -Path $TrustedCACertificateFilePath -Leaf),  $contents
            }

            'Upload Information of Signed Certificates' {
                $boundary = [System.Guid]::NewGuid().ToString()

                $headers.'Content-Type' = 'multipart/form-data; boundary="{0}"' -f $boundary

                $parameters.upload = 'signed'
                
                $allBytes = [System.Io.File]::ReadAllBytes($SignedCertificateFilePath)

                $signedCertificateFileContent = ([System.Text.Encoding]::GetEncoding("iso-8859-1")).GetString($allBytes)
                
                $signedCertificateFileName = Split-Path -Path $SignedCertificateFilePath -Leaf

                $allBytes = [System.Io.File]::ReadAllBytes($KeyFilePath)

                $keyFileContent = ([System.Text.Encoding]::GetEncoding("iso-8859-1")).GetString($allBytes)
                
                $keyFileName = Split-Path -Path $KeyFilePath -Leaf

                $allBytes = [System.Io.File]::ReadAllBytes($IntermediaryCertificateFilePath)

                $intermediaryCertificateFileContent = ([System.Text.Encoding]::GetEncoding("iso-8859-1")).GetString($allBytes)
                
                $intermediaryCertificateFileName = Split-Path -Path $IntermediaryCertificateFilePath -Leaf

                $bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($Password)

                $clearPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)

                $postData = @"
--$boundary
Content-Disposition: form-data; name=`"name`" 

$Name
--$boundary
Content-Disposition: form-data; name=`"type`" 

$Type
--$boundary
Content-Disposition: form-data; name=`"key_type`" 

$KeyType
--$boundary
Content-Disposition: form-data; name=`"signed_certificate`"; filename=`"$signedCertificateFileName`"

$signedCertificateFileContent
--$boundary
Content-Disposition: form-data; name=`"assign_associated_key`" 

$AssignAssociatedKey
--$boundary
Content-Disposition: form-data; name=`"key`"; filename=`"$keyFileName`"

$keyFileContent
--$boundary
Content-Disposition: form-data; name=`"intermediary_certificate`"; filename=`"$intermediaryCertificateFileName`"

$intermediaryCertificateFileContent
--$boundary
Content-Disposition: form-data; name=`"allow_private_key_export`" 

$AllowPrivateKeyExport
--$boundary
Content-Disposition: form-data; name=`"password`" 

$clearPassword
--$boundary
"@
            }
        }

        try {
            Invoke-API -Path 'restapi/v3/certificates' -Method Post -PostData $postData -Headers $headers -Parameters $parameters
        } catch {
            if ($PSVersionTable.PSVersion.Major -lt 6) {
                if ($_.Exception.Response) {  
                    $streamReader = New-Object -TypeName 'System.IO.StreamReader' -ArgumentList $_.Exception.Response.GetResponseStream()
                    $streamReader.BaseStream.Position = 0
                    $streamReader.DiscardBufferedData()
                    $responseBody = $streamReader.ReadToEnd()
                }
            }
            else {
                $responseBody = $_.ErrorDetails.Message
            }

            Write-Debug "ResponseBody: `n$responseBody`n"

            throw
        }

        # $httpClientHandler = New-Object -TypeName 'System.Net.Http.HttpClientHandler'

        # $authenticationHeaderValue = New-Object -TypeName 'System.Net.Http.Headers.AuthenticationHeaderValue' -ArgumentList @("Basic", [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes("{0}`r`n:" -f $Script:BWAF_TOKEN.token)))
        
        # $mediaTypeWithQualityHeaderValue = New-Object -TypeName 'System.Net.Http.Headers.MediaTypeWithQualityHeaderValue' -ArgumentList 'application/json'

        # $httpClient = New-Object -TypeName 'System.Net.Http.Httpclient' -ArgumentList $httpClientHandler

        # $httpClient.DefaultRequestHeaders.Add('Authorization', $authenticationHeaderValue)
        # $httpClient.DefaultRequestHeaders.Add('Accept', $mediaTypeWithQualityHeaderValue)

        # $multipartFormDataContent = New-Object -TypeName 'System.Net.Http.MultipartFormDataContent'

        # $stringContent = New-Object -TypeName 'System.Net.Http.StringContent' -ArgumentList $Name
        # $stringContent.Headers.Add('Content-Disposition', 'form-data; name="name"');

        # $multipartFormDataContent.Add($stringContent, "name");

        # $fileStream = New-Object -TypeName 'System.IO.FileStream' -ArgumentList @($Path, [System.IO.FileMode]::Open)

        # $streamContent = New-Object -TypeName 'System.Net.Http.StreamContent' -ArgumentList $fileStream
        # $streamContent.Headers.Add('Content-Type', 'application/x-x509-ca-cert')
        # $streamContent.Headers.Add('Content-Disposition', 'form-data; name="trusted_certificate"; filename="cert.cer"')
        
        # $multipartFormDataContent.Add($streamContent, "trusted_certificate", "cert.cer")
 
        # try {
            
        #     $response = $httpClient.PostAsync("http://52.174.105.181:8000/restapi/v3/certificates?upload=trusted", $multipartFormDataContent).Result
 
		# 	if (!$response.IsSuccessStatusCode)
		# 	{
		# 		$responseBody = $response.Content.ReadAsStringAsync().Result
		# 		$errorMessage = "Status code {0}. Reason {1}. Server reported the following message: {2}." -f $response.StatusCode, $response.ReasonPhrase, $responseBody
 
		# 		throw [System.Net.Http.HttpRequestException] $errorMessage
		# 	}
 
		# 	return $response.Content.ReadAsStringAsync().Result
        # }
        # catch
        # {
		# 	$PSCmdlet.ThrowTerminatingError($_)
        # }
        # finally
        # {
        #     if($null -ne $httpClient)
        #     {
        #         $httpClient.Dispose()
        #     }
 
        #     if($null -ne $response)
        #     {
        #         $response.Dispose()
        #     }
        # }
    }
}

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
#>
function Verb-Noun {
    [CmdletBinding(DefaultParameterSetName='Parameter Set 1',
                   SupportsShouldProcess=$true,
                   PositionalBinding=$false,
                   HelpUri = 'http://www.microsoft.com/',
                   ConfirmImpact='Medium')]
    [Alias()]
    [OutputType([String])]
    Param (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   Position=0,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false, 
                   ParameterSetName='Parameter Set 1')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [ValidateCount(0,5)]
        [ValidateSet("sun", "moon", "earth")]
        [Alias("p1")] 
        $Param1,
        
        # Param2 help description
        [Parameter(ParameterSetName='Parameter Set 1')]
        [AllowNull()]
        [AllowEmptyCollection()]
        [AllowEmptyString()]
        [ValidateScript({$true})]
        [ValidateRange(0,5)]
        [int]
        $Param2,
        
        # Param3 help description
        [Parameter(ParameterSetName='Another Parameter Set')]
        [ValidatePattern("[a-z]*")]
        [ValidateLength(0,15)]
        [String]
        $Param3
    )
    
    begin {
    }
    
    process {
        if ($pscmdlet.ShouldProcess("Target", "Operation")) {
            
        }
    }
    
    end {
    }
}