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
    https://campus.barracuda.com/product/webapplicationfirewall/article/WAF/RESTAPIServiceGroup/
#>
function New-Certificate {
    [CmdletBinding()]
    [Alias()]
    [OutputType([PSCustomObject])]
    Param (
        # Name help description
        [Parameter(
            Mandatory = $true,
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [String]
        $Name,

        # Path help description
        [Parameter(
            Mandatory = $true,
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateScript({Test-Path -Path $_ -PathType Leaf})]
        [ValidateNotNullOrEmpty()]
        [String]
        $Path
    )
    
    process {
        @{
            'name' = $Name
            'trusted_server_certificate' = [Convert]::ToBase64String((Get-Content -Path $Path -Encoding Byte))
        } | Invoke-API -Path '/restapi/v3/certificates' -Parameters @{'upload' = 'trusted_server'} -Method Post -Headers @{'Content-Type'='multipart/form-data'}
    }
}