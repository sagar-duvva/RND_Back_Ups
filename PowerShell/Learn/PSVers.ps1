#PSVers
# Check PowerShell Version

# Method 1: Using $PSVersionTable
$PSVersionTable # Command within a PowerShell session.
$PSVersionTable.PSVersion
$PSVersionTable.PSVersion.Major


# Method 2: Using Get-Host
Get-Host # To retrieve host-specific version details.

# Method 3: Using Get-Command
(Get-Command powershell).Version


# Method 4
$Host
$Host.Version # which displays the version number directly.


# Method 5: Using PowerShell Core on Linux
pwsh --version

