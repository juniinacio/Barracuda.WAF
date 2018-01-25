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
function Get-ExceptionResponse {
    [cmdletbinding()]
    Param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.ErrorRecord]
        $InputObject
    )

    process {
        if ($PSVersionTable.PSVersion.Major -lt 6) {
            if ($InputObject.Exception.Response) {  
                $reader = New-Object -TypeName 'System.IO.StreamReader' -ArgumentList $_.Exception.Response.GetResponseStream()
                
                $reader.BaseStream.Position = 0
                $reader.DiscardBufferedData()
                
                $reader.ReadToEnd()
            }
        }
        else {
            $_.ErrorDetails.Message
        }
    }
}