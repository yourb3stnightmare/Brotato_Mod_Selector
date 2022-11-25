# Brotato_Mod_Selector
This is a simple Powershell script that allows you to select a mod pck file and then launches the game with the selected pck file. The game is launched through Steam, and passes launch options to use the selected pck file as the main pack. This method does not require any files to be copied to or modified in the game directory.

Due to the way it is written and the dependency on Steam, this script is currently only compatible with the Steam version of Brotato running on a version of Windows that has Powershell. This is likely limited to Windows 7 SP1 or greater (unverified), Windows 10, and Windows 11. Actual milage may vary.

# Installation
Download and extract the zip file. This can be run from anywhere, but it's best to install it to C:\Mod_Selector as there is a Windows link included that assumes this location. The link is easier to use, and unlike the script, it can be pinned to the start menu.

# Usage
If you installed it to C:\Mod_Selector, you can run the script by running the Brotato_Mod_Selector link. If not, you can right click on the "Brotato_Mod_Selector.ps1" script and select "Run with Powershell".

The script will prompt you to select a mod pck file. Once selected, the script will launch the game through Steam with the selected pck file.
