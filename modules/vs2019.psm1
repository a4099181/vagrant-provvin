Function Install-VisualStudio2019
{
<#
    .SYNOPSIS
    This function installs Visual Studio 2019 Enterprise with custom workloads and components.

    .DESCRIPTION
    This function in details:
    * downloads Visual Studio from specified installer URI,
    * takes a Visual Studio components list to install from configuration file,
    * skips components marked as disabled,
    * runs the installer silently with all components left.

    The list of the Visual Studio workloads and components is available at
    https://docs.microsoft.com/pl-pl/visualstudio/install/workload-and-component-ids?view=vs-2019

    .PARAMETER CfgFile
    Configuration file.

    .PARAMETER InstallerUri
    Installer URI to download it from.

    .LINK
    https://github.com/a4099181/vagrant-provvin/blob/master/docs/Install-VisualStudio2019.md

    .LINK
    https://github.com/a4099181/vagrant-provvin/blob/master/modules/vs2019.psm1

    .LINK
    https://www.visualstudio.com/en-us/productinfo/vs2019-install-product--list
#>
    Param ( [Parameter(Mandatory=$true)][String] $CfgFile
          , [String] $InstallerUri='https://aka.ms/vs/16/release/vs_Enterprise.exe')

    $cfg = Get-Content $CfgFile | ConvertFrom-Json

    if ( -Not $cfg.vs2019.disabled )
    {
        $installerPath = Join-Path $env:LOCALAPPDATA 'Temp\vs_installer.exe'

        if (-Not (Test-Path ($installerPath)))
        {
            Invoke-WebRequest -Uri $InstallerUri -OutFile $installerPath
        }

        $components = $cfg.vs2019.components |
            Where-Object   { -Not $_.disabled } |
            ForEach-Object { "--add $($_.id)" }

        Start-Process -Wait -FilePath $installerPath -ArgumentList ( "--quiet",
            "--wait", "--norestart", "--nickname vagrant19",
            "--addProductLang en-US", "--removeProductLang pl-PL" + $components )
    }
}

Function Install-VisualStudio2019Packages
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
    https://github.com/a4099181/vagrant-provvin/blob/master/docs/Install-VisualStudio2019Packages.md

    .LINK
    https://github.com/a4099181/vagrant-provvin/blob/master/modules/vs2019.psm1

    .LINK
    https://chocolatey.org/packages
#>
    Param ( [Parameter(Mandatory=$true)][String] $CfgFile )

    $cfg = Get-Content $CfgFile | ConvertFrom-Json

    if ( -Not $cfg.vs2019.disabled )
    {
        $cfg.vs2019.chocolatey.packages |
            Where-Object   { -Not $_.disabled } |
            ForEach-Object { cinst --no-progress --limit-output --ignore-checksums --allow-empty-checksums -y $_.id }
    }
}
