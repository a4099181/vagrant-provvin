Function Invoke-GitConfig
{
<#
    .SYNOPSIS
    Applies local configuration for git repository.

    .PARAMETER Json
    A piece of the JSON file.

    .PARAMETER RepositoryFolder
    Git repository folder.

    .INPUTS
    PSCustomObject (Json object)
#>
    Param ( [Parameter(Mandatory=$true)][String] $RepositoryFolder,
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)] $Json
     )

    Process
    {
        $Json.psobject.Properties |
            ForEach-Object {
                $key = $_.Name.Replace( "-", ".")
                git -C $RepositoryFolder config $key $_.Value
            }
    }
}

Function Copy-GitRepositories
{
<#
    .SYNOPSIS
    This function clones git respositories enumerated in configuration file.

    .DESCRIPTION
    This function in details:
    * creates destination folder if it not exists,
    * takes a repositores list to clone from configuration file,
    * skips repositories marked as disabled,
    * clones each repository left,
    * uses a git that should be already provisioned and accessible,
    * clones the repositories into specified destination folder,
    * initializes submodules within repositories.

    .PARAMETER CfgFile
    Configuration file.

    .PARAMETER KeyFile
    Encryption key file. If you don't have it, please see New-EncryptionKey.

    .PARAMETER DestinationFolder
    Destination folder for cloned repositories.

    .LINK
    https://github.com/a4099181/vagrant-officeVM/blob/master/docs/Copy-GitRepositories.md

    .LINK
    https://github.com/a4099181/vagrant-officeVM/blob/master/docs/New-EncryptionKey.md

    .LINK
    https://github.com/a4099181/vagrant-officeVM/blob/master/docs/Protect-Config.md

    .LINK
    https://github.com/a4099181/vagrant-officeVM/blob/master/provision/powershell/git-clone.psm1
#>
    Param (
        [Parameter(Mandatory=$true)][String] $CfgFile,
        [Parameter(Mandatory=$true)] [String] $KeyFile,
        [String] $DestinationFolder = ( Join-Path $env:UserProfile 'MyProjects' ) )

    if ((Test-Path $DestinationFolder)-eq 0)
    {
        New-Item -Path $DestinationFolder -ItemType Directory
    }

    ( Get-Content $CfgFile | ConvertFrom-Json ).repos |
        Where-Object { -Not $_.disabled } |
        ForEach-Object {
            Start-Process -FilePath 'git' `
                          -ArgumentList "clone --recursive $($_.url)" `
                          -WorkingDirectory $DestinationFolder `
                          -NoNewWindow `
                          -PassThru `
                          -Wait

            If ( $_.secret )
            {
                $_.secret | Decrypt $KeyFile
                $subdir = ( [IO.FileInfo] ( [ URI ] $_.url).AbsolutePath ).BaseName
                $_.secret | Invoke-GitConfig ( Join-Path $DestinationFolder $subdir )
            }
        }
}
