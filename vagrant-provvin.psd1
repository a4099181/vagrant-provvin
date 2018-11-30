#
# Module manifest for module 'vagrant-provvin'
#
# Generated by: seb!
#
# Generated on: 02.02.2017
#

@{

# Script module or binary module file associated with this manifest.
# RootModule = ''

# Version number of this module.
ModuleVersion = '1.0'

# Supported PSEditions
# CompatiblePSEditions = @()

# ID used to uniquely identify this module
GUID = 'aa742d68-4afe-472c-ab8f-14756f2cf88b'

# Author of this module
Author = 'seb!'

# Company or vendor of this module
# CompanyName = ''

# Copyright statement for this module
# Copyright = '(c) 2017 seb!. All rights reserved.'

# Description of the functionality provided by this module
# Description = ''

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = '3.0'

# Name of the Windows PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# CLRVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
NestedModules = @( 'modules\chocolatey.psm1'
    , 'modules\config.psm1'
    , 'modules\crypto.psm1'
    , 'modules\defender.psm1'
    , 'modules\download.psm1'
    , 'modules\extend-PATH-environment-variable.psm1'
    , 'modules\git-clone.psm1'
    , 'modules\map-drives.psm1'
    , 'modules\Set-QuickAccess.psm1'
    , 'modules\vault.psm1'
    , 'modules\vpn.psm1'
    , 'modules\vscode.psm1'
    , 'modules\vs2017.psm1'
)

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = @( 'Add-SystemPath'
    , 'Add-DriveMappings'
    , 'Add-GenericWindowsCredentials'
    , 'Add-WindowsCredentials'
    , 'Add-WindowsDefenderExclusions'
    , 'Add-VpnConnectionTriggers'
    , 'Connect-Vpn' , 'Copy-GitRepositories'
    , 'Expand-DownloadedArchive'
    , 'Install-CommonPackages'
    , 'Install-VisualStudioCodeExtensions'
    , 'Install-VisualStudio2017'
    , 'Install-VisualStudio2017Extensions'
    , 'Install-VisualStudio2017Packages'
    , 'Merge-ConfigurationFiles'
    , 'New-EncryptionKey'
    , 'Protect-Config'
    , 'Reset-GitAutoCrLf'
    , 'Set-QuickAccess'
    , 'Set-QuickAccessFromCfg'
    , 'Unprotect-Config'
    )

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = @()

# Variables to export from this module
VariablesToExport = '*  '

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = @()

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        # Tags = @()

        # A URL to the license for this module.
        LicenseUri = 'https://raw.githubusercontent.com/a4099181/vagrant-provvin/master/LICENSE'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/a4099181/vagrant-provvin'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        # ReleaseNotes = ''

    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
HelpInfoURI = 'https://github.com/a4099181/vagrant-provvin/docs'

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}
