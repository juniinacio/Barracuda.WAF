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
function Add-Account {
    [CmdletBinding()]
    [Alias()]
    [OutputType([PSCustomObject])]
    Param (
        # Credential help description
        [Parameter(
            Mandatory = $true,
            Position = 0,
            ValueFromPipeline = $true
        )]
        [ValidateNotNull()]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.CredentialAttribute()]
        $Credential
    )

    begin {
        $Script:ACCESS_TOKEN = $null
    }
    
    process {
        $postData = @{
            username = $Credential.GetNetworkCredential().UserName
            password = $Credential.GetNetworkCredential().Password
        }
        $Script:ACCESS_TOKEN = Invoke-API -Path '/restapi/v1/login' -Method Post -Data $postData
    }

    end {
        $Script:ACCESS_TOKEN
    }
}