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
    https://campus.barracuda.com/product/webapplicationfirewall/article/WAF/RESTAPISecPolicy/
#>
function Get-ActionPolicy {
    [CmdletBinding(
        DefaultParameterSetName='AttackGroup'
    )]
    [Alias()]
    [OutputType([PSCustomObject])]
    Param (
        # PolicyId help description
        [Parameter(
            Mandatory = $true,
            Position = 0
        )]
        [ValidateNotNullOrEmpty()]        
        [String]
        $PolicyId,

        # AttackGroupId help description
        [Parameter(Mandatory = $false, Position = 1, ValueFromPipeline = $true, ParameterSetName = 'AttackGroup')]
        [Parameter(Mandatory = $true, Position = 1, ParameterSetName = 'AttackAction')]
        [ValidateNotNullOrEmpty()]
        [String]
        $AttackGroupId,

        # Action help description
        [Parameter(Mandatory = $true, Position = 2, ParameterSetName = 'AttackAction')]
        [Switch]
        $Action,

        # ActionId help description
        [Parameter(Mandatory = $false, Position = 3, ValueFromPipeline = $true, ParameterSetName = 'AttackAction')]
        [ValidateNotNullOrEmpty()]        
        [String[]]
        $ActionId
    )

    process {
        switch ($PSCmdlet.ParameterSetName) {
            AttackGroup {
                if ($PSBoundParameters.ContainsKey('AttackGroupId')) {
                    Invoke-API -Path $('/restapi/v1/security_policies/{0}/attack_groups/{1}' -f $PolicyId, $AttackGroupId)
                } else {
                    Invoke-API -Path $('/restapi/v1/security_policies/{0}/attack_groups' -f $PolicyId)
                }
            }

            AttackAction {
                if ($PSBoundParameters.ContainsKey('ActionId')) {
                    foreach ($act in $ActionId) {
                        Invoke-API -Path $('/restapi/v1/security_policies/{0}/attack_groups/{1}/actions/{2}' -f $PolicyId, $AttackGroupId, $act)
                    }
                } else {
                    Invoke-API -Path $('/restapi/v1/security_policies/{0}/attack_groups/{1}/actions' -f $PolicyId, $AttackGroupId)
                }
            }

            Default {
            }
        }
    }
}