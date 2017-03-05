Function Add-GenericWindowsCredentials
{
<#
    .SYNOPSIS
    This function adds generic Windows Credentials enumerated in configuration file.

    .DESCRIPTION
    This function in details:
    * takes a generic credentials list from configuration file,
    * skips entries marked as disabled,
    * stores all credentials left into Windows Vault,
    * supports encrypted secret data.

    .PARAMETER CfgFile
    Configuration file.

    .PARAMETER KeyFile
    Encryption key file.

    .LINK
    https://github.com/a4099181/vagrant-officeVM/blob/master/docs/Add-GenericWindowsCredentials.md

    .LINK
    https://github.com/a4099181/vagrant-officeVM/blob/master/provision/powershell/vault.psm1
#>
    Param ( [Parameter(Mandatory=$true)][String] $CfgFile
          , [Parameter(Mandatory=$true)][String] $KeyFile )

    $cfg = Get-Content $CfgFile | ConvertFrom-Json

    $cfg.vault |
        Select-Object -expand secret |
        Decrypt $KeyFile

    $pass = ConvertTo-SecureString -AsPlainText -Force "vagrant"
    $cred = New-Object pscredential("vagrant",  $pass)

    $cfg.vault |
        Where-Object   { $_.type -eq "generic" } |
        Where-Object   { -Not $_.disabled } |
        ForEach-Object {
            Start-Process cmdkey  -Credential $cred `
                                  -LoadUserProfile `
                                  -NoNewWindow `
                                  -Wait `
                "/generic:$($_.secret.server) /user:$($_.secret.username) /pass:$($_.secret.password)";
        }
}

Function Add-WindowsCredentials
{
<#
    .SYNOPSIS
    This function adds domain Windows Credentials enumerated in configuration file.

    .DESCRIPTION
    This function in details:
    * takes a domain credentials list from from configuration file,
    * skips entries marked as disabled,
    * stores all credentials left into Windows Vault,
    * supports encrypted secret data.

    .PARAMETER CfgFile
    Configuration file.

    .PARAMETER KeyFile
    Encryption key file.

    .LINK
    https://github.com/a4099181/vagrant-officeVM/blob/master/docs/Add-WindowsCredentials.md

    .LINK
    https://github.com/a4099181/vagrant-officeVM/blob/master/provision/powershell/vault.psm1
#>
    Param ( [Parameter(Mandatory=$true)][String] $CfgFile
          , [Parameter(Mandatory=$true)][String] $KeyFile )

    $cfg = Get-Content $CfgFile | ConvertFrom-Json

    $cfg.vault |
        Select-Object -expand secret |
        Decrypt $KeyFile

    $pass = ConvertTo-SecureString -AsPlainText -Force "vagrant"
    $cred = New-Object pscredential("vagrant",  $pass)

    $cfg.vault |
        Where-Object   { -Not $_.type -Or $_.type -eq "domain" } |
        Where-Object   { -Not $_.disabled } |
        ForEach-Object {
            Start-Process cmdkey  -Credential $cred `
                                  -LoadUserProfile `
                                  -NoNewWindow `
                                  -Wait `
                "/add:$($_.secret.server) /user:$($_.secret.username) /pass:$($_.secret.password)";
        }
}
