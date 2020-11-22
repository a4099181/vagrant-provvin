Function Install-VisualStudio2017
{
<#
    .SYNOPSIS
    This function installs Visual Studio 2017 Enterprise with custom workloads and components.

    .DESCRIPTION
    This function in details:
    * downloads Visual Studio from specified installer URI,
    * takes a Visual Studio components list to install from configuration file,
    * skips components marked as disabled,
    * runs the installer silently with all components left.

    The list of the Visual Studio workloads and components is available at
    https://www.visualstudio.com/en-us/productinfo/vs2017-install-product--list

    .PARAMETER CfgFile
    Configuration file.

    .PARAMETER InstallerUri
    Installer URI to download it from.

    .LINK
    https://github.com/a4099181/vagrant-provvin/blob/master/docs/Install-VisualStudio2017.md

    .LINK
    https://github.com/a4099181/vagrant-provvin/blob/master/modules/vs2017.psm1

    .LINK
    https://www.visualstudio.com/en-us/productinfo/vs2017-install-product--list
#>
    Param ( [Parameter(Mandatory=$true)][String] $CfgFile
          , [String] $InstallerUri='https://aka.ms/vs/15/release/vs_Enterprise.exe')

    $cfg = Get-Content $CfgFile | ConvertFrom-Json

    if ( -Not $cfg.vs2017.disabled )
    {
        $installerPath = Join-Path $env:LOCALAPPDATA 'Temp\vs_installer.exe'

        if (-Not (Test-Path ($installerPath)))
        {
            Invoke-WebRequest -Uri $InstallerUri -OutFile $installerPath
        }

        $components = $cfg.vs2017.components |
            Where-Object   { -Not $_.disabled } |
            ForEach-Object { "--add $($_.id)" }

        Start-Process -Wait -FilePath $installerPath -ArgumentList ( "--quiet",
            "--wait", "--norestart", "--nickname vagrant",
            "--addProductLang en-US", "--removeProductLang pl-PL" + $components )
    }
}

Function Install-VisualStudio2017Packages
{
<#
    .SYNOPSIS
    This function installs Visual Studio related software enumerated in configuration file.

    .DESCRIPTION
    This function in details:
    * takes a Visual Studio related software list to install from a configruation file,
    * skips software marked as disabled,
    * installs all software left,
    * uses chocolatey package manager.

    .PARAMETER CfgFile
    Configuration file.

    .LINK
    https://github.com/a4099181/vagrant-provvin/blob/master/docs/Install-VisualStudio2017Packages.md

    .LINK
    https://github.com/a4099181/vagrant-provvin/blob/master/modules/vs2017.psm1

    .LINK
    https://chocolatey.org/packages
#>
    Param ( [Parameter(Mandatory=$true)][String] $CfgFile )

    $cfg = Get-Content $CfgFile | ConvertFrom-Json

    if ( -Not $cfg.vs2017.disabled )
    {
        $cfg.vs2017.chocolatey.packages |
            Where-Object   { -Not $_.disabled } |
            ForEach-Object { cinst --no-progress --limit-output --ignore-checksums --allow-empty-checksums -y $_.id }
    }
}
