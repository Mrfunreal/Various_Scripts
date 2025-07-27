#------------------------------------------------------------------------------------------------------------------
# PowerShell script to extract icon path and index from a .lnk or .exe file
# Simply create a Save this file, or create a .ps1 file with this content. 
# Run this script, then drop any shortcut (.lnk) or exe onto the powershell window. 
# It will spit out the REG file icon string as such: 
# "Icon"="G:\\Icons\\iconset_Crowbar.dll,6"
#------------------------------------------------------------------------------------------------------------------

param (
    [Parameter(Mandatory=$false)]
    [string]$FilePath
)

# Function to get icon path and index from a shortcut
function Get-ShortcutIcon {
    param ([string]$ShortcutPath)
    try {
        $shell = New-Object -ComObject WScript.Shell
        $shortcut = $shell.CreateShortcut($ShortcutPath)
        $targetPath = $shortcut.TargetPath
        $iconLocation = $shortcut.IconLocation
        $shortcut = $null
        [System.Runtime.Interopservices.Marshal]::ReleaseComObject($shell) | Out-Null
        
        if ($iconLocation) {
            return $iconLocation
        } else {
            # If no specific icon is set, use target path with index 0
            return "$targetPath,0"
        }
    } catch {
        Write-Error "Failed to process shortcut: $_"
        return $null
    }
}

# Function to format the path for registry (double backslashes)
function Format-RegistryPath {
    param ([string]$Path)
    $Path -replace '\\', '\\'
}

# Main logic wrapped in a loop
do {
    # Handle drag-and-drop path (remove quotes and trim)
    if ($FilePath) {
        $FilePath = $FilePath.Trim('"').Trim()
    }

    # Prompt for file path if none provided
    if (-not $FilePath) {
        Write-Host "Drag a .lnk or .exe onto this powershell window. It'll give you icon path and index, for use in REG files."
        Write-Host " "
        $FilePath = Read-Host
        if (-not $FilePath) {
            Write-Host "No path provided. Exiting..."
            Write-Host "`nPress Enter to exit..."
            Read-Host
            exit
        }
        $FilePath = $FilePath.Trim('"').Trim()
    }

    # Process the file
    if (-not (Test-Path $FilePath)) {
        Write-Error "File does not exist: $FilePath"
        $iconString = $null
    } else {
        $extension = [System.IO.Path]::GetExtension($FilePath).ToLower()
        if ($extension -eq '.lnk') {
            $iconString = Get-ShortcutIcon -ShortcutPath $FilePath
        } elseif ($extension -eq '.exe') {
            $iconString = "$FilePath,0"
        } else {
            Write-Error "Unsupported file type. Please provide a .lnk or .exe file."
            $iconString = $null
        }

        if ($iconString) {
            # Format the icon string for registry
            $formattedPath = Format-RegistryPath -Path ($iconString -split ',')[0]
            $iconIndex = ($iconString -split ',')[1]
            $registryString = "`"Icon`"=`"$formattedPath,$iconIndex`""
            $registryString | Set-Clipboard #Copy to clipboard

            Write-Host " "
            Write-Host "         $registryString  (Copied to clipboard)"
            Write-Host " "
        }
    }

    # Prompt for another file
    Write-Host "Drag another .lnk or .exe, or close window."
    $FilePath = Read-Host
    $FilePath = $FilePath.Trim('"').Trim()

} while ($FilePath)

# Final exit message
Write-Host "Exiting..."
Write-Host "`nPress Enter to exit..."
Read-Host
