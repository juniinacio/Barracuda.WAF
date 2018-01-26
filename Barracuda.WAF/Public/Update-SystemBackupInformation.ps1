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
function Update-SystemBackupInformation {
    [CmdletBinding(DefaultParameterSetName = 'SetBackupDestinatioSettingsToAzureStorageAccount')]
    [OutputType([PSCustomObject])]
    Param (
        # AmazonS3BucketName help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'SetBackupDestinatioSettingsToAmazonS3Bucket')]
        [Alias('amazon-s3-bucket-name')]
        [ValidateNotNullOrEmpty()]
        [String]
        $AmazonS3BucketName,

        # AmazonS3DirectoryPath help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'SetBackupDestinatioSettingsToAmazonS3Bucket')]
        [Alias('amazon-s3-directory-path')]
        [ValidateNotNullOrEmpty()]
        [String]
        $AmazonS3DirectoryPath,

        # AzureStorageAccessKey help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'SetBackupDestinatioSettingsToAzureStorageAccount')]
        [Alias('azure-storage-access-key')]
        [ValidateNotNullOrEmpty()]
        [String]
        $AzureStorageAccessKey,

        # AzureStorageAccountName help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'SetBackupDestinatioSettingsToAzureStorageAccount')]
        [Alias('azure-storage-account-name')]
        [ValidateNotNullOrEmpty()]
        [String]
        $AzureStorageAccountName,

        # AzureStorageBlobPath help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'SetBackupDestinatioSettingsToAzureStorageAccount')]
        [Alias('azure-storage-blob-path')]
        [ValidateNotNullOrEmpty()]
        [String]
        $AzureStorageBlobPath,

        # AzureStorageBlobPath help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'SetBackupDestinatioSettingsToAzureStorageAccount')]
        [Alias('azure-storage-container-name')]
        [ValidateNotNullOrEmpty()]
        [String]
        $AzureStorageContainerName,

        # FtpAddress help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'SetBackupDestinatioSettingsToFTP')]
        [Alias('ftp-address')]
        [ValidateNotNullOrEmpty()]
        [String]
        $FtpAddress,

        # FtpPassword help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'SetBackupDestinatioSettingsToFTP')]
        [Alias('ftp-password')]
        [ValidateNotNullOrEmpty()]
        [SecureString]
        $FtpPassword,

        # FtpPath help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'SetBackupDestinatioSettingsToFTP')]
        [Alias('ftp-path')]
        [ValidateNotNullOrEmpty()]
        [String]
        $FtpPath,

        # FtpPort help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'SetBackupDestinatioSettingsToFTP')]
        [Alias('ftp-port')]
        [ValidateRange(1, 65535)]
        [Int]
        $FtpPort = 21,

        # FtpUsername help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'SetBackupDestinatioSettingsToFTP')]
        [Alias('ftp-username')]
        [ValidateNotNullOrEmpty()]
        [String]
        $FtpUsername,

        # FtpsAddress help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'SetBackupDestinatioSettingsToFTPS')]
        [Alias('ftps-address')]
        [ValidateNotNullOrEmpty()]
        [String]
        $FtpsAddress,

        # FtpsPassword help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'SetBackupDestinatioSettingsToFTPS')]
        [Alias('ftps-password')]
        [ValidateNotNullOrEmpty()]
        [SecureString]
        $FtpsPassword,

        # FtpsPath help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'SetBackupDestinatioSettingsToFTPS')]
        [Alias('ftps-path')]
        [ValidateNotNullOrEmpty()]
        [String]
        $FtpsPath,

        # FtpsPort help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'SetBackupDestinatioSettingsToFTPS')]
        [Alias('ftps-port')]
        [ValidateRange(1, 65535)]
        [Int]
        $FtpsPort = 21,

        # FtpsUsername help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'SetBackupDestinatioSettingsToFTPS')]
        [Alias('ftps-username')]
        [ValidateNotNullOrEmpty()]
        [String]
        $FtpsUsername,

        # SmbAddress help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'SetBackupDestinatioSettingsToSMB')]
        [Alias('smb-address')]
        [ValidateNotNullOrEmpty()]
        [String]
        $SmbAddress,

        # SmbPassword help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'SetBackupDestinatioSettingsToSMB')]
        [Alias('smb-password')]
        [ValidateNotNullOrEmpty()]
        [SecureString]
        $SmbPassword,

        # SmbPath help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'SetBackupDestinatioSettingsToSMB')]
        [Alias('smb-path')]
        [ValidateNotNullOrEmpty()]
        [String]
        $SmbPath,

        # SmbPort help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'SetBackupDestinatioSettingsToSMB')]
        [Alias('smb-port')]
        [ValidateRange(1, 65535)]
        [Int]
        $SmbPort = 445,

        # SmbUsername help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'SetBackupDestinatioSettingsToSMB')]
        [Alias('smb-username')]
        [ValidateNotNullOrEmpty()]
        [String]
        $SmbUsername,

        # UseNtlm help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'SetBackupDestinatioSettingsToSMB')]
        [Alias('use-ntlm')]
        [ValidateSet('Yes', 'No')]
        [String]
        $UseNtlm,

        # EncryptBackup help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'SetBackupEncryptionSettings')]
        [Alias('encrypt-backup')]
        [ValidateSet('Yes', 'No')]
        [String]
        $EncryptBackup,

        # BackupEncryptionKey help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'SetBackupEncryptionSettings')]
        [Alias('backup-encryption-key')]
        [ValidateNotNullOrEmpty()]
        [String]
        $BackupEncryptionKey,

        # BackupScheduleLocation help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'SetScheduledBackups')]
        [Alias('backup-schedule-location')]
        [ValidateSet('Amazon S3', 'Azure Blob', 'FTP', 'FTPS', 'Cloud', 'SMB')]
        [String]
        $BackupScheduleLocation,

        # BackupsToKeep help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'SetScheduledBackups')]
        [Alias('backups-to-keep')]
        [ValidateNotNullOrEmpty()]
        [String]
        $BackupsToKeep,

        # BackupsToKeep help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'SetScheduledBackups')]
        [Alias('day-of-week')]
        [ValidateSet('Daily', 'Off', 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday')]
        [String]
        $DayOfWeek,

        # HourOfDay help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'SetScheduledBackups')]
        [Alias('hour-of-day')]
        [ValidateNotNullOrEmpty()]
        [String]
        $HourOfDay,

        # HourOfDay help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'SetScheduledBackups')]
        [Alias('minute-of-hour')]
        [ValidateNotNullOrEmpty()]
        [String]
        $MinuteOfHour,

        # ExcludeManagementInterfaceConfigurations help description
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'SetRestoreBackups')]
        [Alias('exclude-management-interface-configurations')]
        [ValidateSet('Yes', 'No')]
        [String]
        $ExcludeManagementInterfaceConfigurations
    )

    process {
        try {

            switch ($PSCmdlet.ParameterSetName) {
                'SetBackupDestinatioSettingsToAmazonS3Bucket' {
                    $PSBoundParameters.source = 'Amazon S3'
                }

                'SetBackupDestinatioSettingsToAzureStorageAccount' {
                    $PSBoundParameters.source = 'Azure Blob'
                }

                'SetBackupDestinatioSettingsToFTP' {
                    $bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($FtpPassword)

                    $clearPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)
                    
                    $PSBoundParameters.FtpPassword = $clearPassword
                    
                    $PSBoundParameters.source = 'FTP'
                }

                'SetBackupDestinatioSettingsToFTPS' {
                    $bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($FtpsPassword)

                    $clearPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)
                    
                    $PSBoundParameters.FtpsPassword = $clearPassword
                    
                    $PSBoundParameters.source = 'FTPS'
                }

                'SetBackupDestinatioSettingsToSMB' {
                    $bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($SmbPassword)

                    $clearPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)
                    
                    $PSBoundParameters.SmbPassword = $clearPassword
                    
                    $PSBoundParameters.source = 'SMB'
                }
            }

            $PSBoundParameters |
                ConvertTo-PostData |
                    Invoke-API -Path '/restapi/v3/backup' -Method Put
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