Get-Module -Name Barracuda.WAF | Remove-Module -Force
Import-Module $(Join-Path -Path $PSScriptRoot -ChildPath '../Barracuda.WAF/Barracuda.WAF.psd1') -Force

InModuleScope Barracuda.WAF {
    Describe "Update-BarracudaWAFSystemBackupInformation" {

        It "should support backup to Amazon S3 bucket" {
            Mock Invoke-Api {}

            $inputObject = @"
{
    "amazon-s3-bucket-name": "string",
    "amazon-s3-directory-path": "string"
}
"@          | ConvertFrom-Json

            $inputObject | Update-BarracudaWAFSystemBackupInformation

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/backup" `
                -and    $Method -eq 'Put' `
                -and    $PostData.'amazon-s3-bucket-name' -eq 'string' `
                -and    $PostData.'amazon-s3-directory-path' -eq 'string' `
                -and    $PostData.source -eq 'Amazon S3'
            } -Scope It
        }

        It "should support backup to Azure storage account" {
            Mock Invoke-Api {}

            $inputObject = @"
{
    "azure-storage-access-key": "string",
    "azure-storage-account-name": "string",
    "azure-storage-blob-path": "string",
    "azure-storage-container-name": "string"
}
"@          | ConvertFrom-Json

            $inputObject | Update-BarracudaWAFSystemBackupInformation

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/backup" `
                -and    $Method -eq 'Put' `
                -and    $PostData.'azure-storage-access-key' -eq 'string' `
                -and    $PostData.'azure-storage-account-name' -eq 'string' `
                -and    $PostData.'azure-storage-blob-path' -eq 'string' `
                -and    $PostData.'azure-storage-container-name' -eq 'string' `
                -and    $PostData.source -eq 'Azure Blob'
            } -Scope It
        }

        It "should support backup to FTP" {
            Mock Invoke-Api {}

            $params = @{
                "ftp-address" = 'string'
                "ftp-password" = ConvertTo-SecureString -String 'V3ryC0mpl#x' -AsPlainText -Force
                "ftp-path" = 'string'
                "ftp-port" = 21
                "ftp-username" = 'string'
            }
            Update-BarracudaWAFSystemBackupInformation @params 

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/backup" `
                -and    $Method -eq 'Put' `
                -and    $PostData.'ftp-address' -eq 'string' `
                -and    $PostData.'ftp-password' -eq 'V3ryC0mpl#x' `
                -and    $PostData.'ftp-path' -eq 'string' `
                -and    $PostData.'ftp-port' -eq '21' `
                -and    $PostData.'ftp-username' -eq 'string' `
                -and    $PostData.source -eq 'FTP'
            } -Scope It
        }

        It "should support backup to FTPS" {
            Mock Invoke-Api {}

            $params = @{
                "ftps-address" = "string"
                "ftps-password" = ConvertTo-SecureString -String 'V3ryC0mpl#x' -AsPlainText -Force
                "ftps-path" = "string"
                "ftps-port" = 21
                "ftps-username" = "string"
            }
            Update-BarracudaWAFSystemBackupInformation @params 

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/backup" `
                -and    $Method -eq 'Put' `
                -and    $PostData.'ftps-address' -eq 'string' `
                -and    $PostData.'ftps-password' -eq 'V3ryC0mpl#x' `
                -and    $PostData.'ftps-path' -eq 'string' `
                -and    $PostData.'ftps-port' -eq '21' `
                -and    $PostData.'ftps-username' -eq 'string' `
                -and    $PostData.source -eq 'FTPS'
            } -Scope It
        }

        It "should support backup to SMB" {
            Mock Invoke-Api {}

            $params = @{
                "smb-address" = "string"
                "smb-password" = ConvertTo-SecureString -String 'V3ryC0mpl#x' -AsPlainText -Force
                "smb-path" = "string"
                "smb-port" = 445
                "smb-username" = "string"
                "use-ntlm" = "Yes"
            }
            Update-BarracudaWAFSystemBackupInformation @params 

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/backup" `
                -and    $Method -eq 'Put' `
                -and    $PostData.'smb-address' -eq 'string' `
                -and    $PostData.'smb-password' -eq 'V3ryC0mpl#x' `
                -and    $PostData.'smb-path' -eq 'string' `
                -and    $PostData.'smb-port' -eq '445' `
                -and    $PostData.'smb-username' -eq 'string' `
                -and    $PostData.'use-ntlm' -eq 'Yes' `
                -and    $PostData.source -eq 'SMB'
            } -Scope It
        }

        It "should support setting backup settings" {
            Mock Invoke-Api {}

            $inputObject = @"
{
    "encrypt-backup": "Yes",
    "backup-encryption-key": "string"
}
"@          | ConvertFrom-Json
            
            $inputObject | Update-BarracudaWAFSystemBackupInformation 

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/backup" `
                -and    $Method -eq 'Put' `
                -and    $PostData.'encrypt-backup' -eq 'Yes' `
                -and    $PostData.'backup-encryption-key' -eq 'string'
            } -Scope It
        }

        It "should support setting scheduled backups" {
            Mock Invoke-Api {}

            $inputObject = @"
{
    "backup-schedule-location": "Amazon S3",
    "backups-to-keep": 5,
    "day-of-week": "Off",
    "hour-of-day": "string",
    "minute-of-hour": "string"
}
"@          | ConvertFrom-Json
            
            $inputObject | Update-BarracudaWAFSystemBackupInformation 

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/backup" `
                -and    $Method -eq 'Put' `
                -and    $PostData.'backup-schedule-location' -eq 'Amazon S3' `
                -and    $PostData.'backups-to-keep' -eq '5' `
                -and    $PostData.'day-of-week' -eq 'Off' `
                -and    $PostData.'hour-of-day' -eq 'string' `
                -and    $PostData.'minute-of-hour' -eq 'string'
            } -Scope It
        }

        It "should support setting restore backups settings" {
            Mock Invoke-Api {}

            $inputObject = @"
{
    "exclude-management-interface-configurations": "Yes"
}
"@          | ConvertFrom-Json
            
            $inputObject | Update-BarracudaWAFSystemBackupInformation 

            Assert-MockCalled Invoke-Api -ParameterFilter {
                        $Path -eq "/restapi/v3/backup" `
                -and    $Method -eq 'Put' `
                -and    $PostData.'exclude-management-interface-configurations' -eq 'Yes'
            } -Scope It
        }
    }
}
