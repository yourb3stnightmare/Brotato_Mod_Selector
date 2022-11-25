Add-Type -AssemblyName System.Windows.Forms

$ConfigFile="$PSScriptRoot\Brotato_Mod_Selector.json"
$ConfigTable=@{}
$ConfigTable.Add("modpath", "$PSScriptRoot\packs")
$ConfigTable.Add("gamepath", "")

If( Test-Path -Path "$ConfigFile" )
{
    $ConfigTable=Get-Content -Path "$ConfigFile" | ConvertFrom-Json
}
$gamepathStr = $ConfigTable.gamepath.ToString()
$gamepathStr = $gamepathStr.Trim()
If( $gamepathStr -eq "" )
{
    # Get Game exe path
    $FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{ InitialDirectory = [Environment]::GetFolderPath('Desktop') }
    $FileBrowser.FileName="Brotato.exe"
    echo "--- Locate Brotato executable ---"
    $null = $FileBrowser.ShowDialog()
    $gamepathStr = Out-String -InputObject $FileBrowser.FileName | Split-Path
    $ConfigTable.gamepath = $gamepathStr
} 
echo "Using Brotato directory: $gamepathStr`n"

# Select mod pck file
$modpathStr = (Out-String -InputObject $ConfigTable.modpath).Trim()
If( $modpathStr -eq "" )
{
    $modpathStr=$PSScriptRoot
}
$FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{ InitialDirectory = "$modpathStr" }
$FileBrowser.FileName="Modded_Brotato.pck"
echo "--- Select modded Brotato pck file to install ---"
$null = $FileBrowser.ShowDialog()
$ModPck = (Out-String -InputObject $FileBrowser.FileName).Trim()
$ConfigTable.modpath = Split-Path -Path "$ModPck"

If ( $ModPck -ne "Modded_Brotato.pck")
{
    $ConfigTable | ConvertTo-Json | Out-File -FilePath "$ConfigFile"
    Copy-Item -Force -Path "$ModPck" -Destination "$gamepathStr\Brotato.pck"
    $tempForm = New-Object System.Windows.Forms.Form
    $tempForm.TopMost = 1
    #[System.Windows.Forms.MessageBox]::Show($tempForm, "Installed pack file:`n$ModPck`n`nTo location:`n$gamepathStr\Brotato.pck", "Success")
	echo "Installed pack file:`n$ModPck`n`nTo location:`n$gamepathStr\Brotato.pck"
	echo "Launching Brotato"
	Invoke-Expression "$PSScriptRoot\Brotato.url"
}