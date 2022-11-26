Add-Type -AssemblyName System.Windows.Forms

$DefaultPackDirStr = "$PSScriptRoot\packs"
$DefaultBrotatoSteamAppIdStr = "1942280"
$ConfigFileStr="$PSScriptRoot\Brotato_Mod_Selector.json"

# Attempt to get the Steam install location from the registry 64-bit OS location
$SteamInstallPathStr = (Get-ItemPropertyValue -ErrorAction SilentlyContinue -Path "HKLM:\SOFTWARE\WOW6432Node\Valve\Steam" -Name "InstallPath" | Out-String).Trim()
# If that fails, try the 32-bit OS location
if ($SteamInstallPathStr -eq "") 
{
    $SteamInstallPathStr = (Get-ItemPropertyValue -ErrorAction SilentlyContinue -Path "HKLM:\SOFTWARE\Valve\Steam" -Name "InstallPath" | Out-String).Trim()
}
if ($SteamInstallPathStr -eq "")
{
    echo "Steam path not found in registry. Is it installed?"
    exit 1
}
$SteamExe = "$SteamInstallPathStr\Steam.exe"

$ConfigTable=@{}
$ConfigTable.Add("ModPackPath", $DefaultPackDirStr)
$ConfigTable.Add("BrotatoSteamAppId", $DefaultBrotatoSteamAppIdStr)

# Load previously used modpack location from JSON
If( Test-Path -Path "$ConfigFileStr" )
    $ConfigTable=Get-Content -Path "$ConfigFileStr" | ConvertFrom-Json
{
}
$ModPathStr = (Out-String -InputObject $ConfigTable.ModPackPath).Trim()
If( $ModPathStr -eq "" )
{
    $ModPathStr = $DefaultPackDirStr
}
$BrotatoSteamAppIdStr = (Out-String -InputObject $ConfigTable.BrotatoSteamAppId).Trim()
If( $BrotatoSteamAppIdStr -eq "" )
{
    $BrotatoSteamAppIdStr = $DefaultBrotatoSteamAppIdStr
}

# Select mod pck file
$FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{ InitialDirectory = "$ModPathStr" }
$FileBrowser.FileName="Modded_Brotato.pck"
echo "--- Select modded Brotato pck file to install ---"
$null = $FileBrowser.ShowDialog()
$ModPck = (Out-String -InputObject $FileBrowser.FileName).Trim()
$ConfigTable.ModPackPath = Split-Path -Path "$ModPck"

If ( $ModPck -ne "Modded_Brotato.pck")
{
    $ConfigTable | ConvertTo-Json | Out-File -FilePath "$ConfigFileStr"
    echo "Launching Brotato"
    & "$SteamExe" -applaunch $BrotatoSteamAppIdStr --main-pack "$ModPck"
    exit 0
}