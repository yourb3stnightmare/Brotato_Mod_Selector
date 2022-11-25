# Brotato_Mod_Selector
This is a simple script that allows you to select a mod pck file and then launches the game with the selected pck file. The game is launched through Steam, and passes launch options to use the selected pck file as the main pack. This method does not require any files to be copied to or modified in the game directory.

There are two version of this script, one written in Powershell, and one in Python. Both scripts have a dependency on Steam to launch the game.

The Python version is compiled as an EXE for release. You may need to install the latest Visual C++ Redistributable package to install it:
https://learn.microsoft.com/en-US/cpp/windows/latest-supported-vc-redist?view=msvc-170

The Powershell version it more transparent as to what it does, but Windows may prevent it from running on your system due to security settings.

# Installation
Download and extract the zip file. This can be run from anywhere, but it's best to install it to C:\Brotato_Mod_Selector if you plan to use the Powershell script as there is a Windows link included that assumes this location. The link is easier to use, and unlike the script, it can be pinned to the start menu.

# Usage
The script will prompt you to select a mod pck file. Once selected, the script will launch the game through Steam with the selected pck file.

Powershell Version:
If you installed it to C:\Brotato_Mod_Selector, you can run the script by running the Brotato_Mod_Selector link. If not, you can right click on the "Brotato_Mod_Selector.ps1" script and select "Run with Powershell".

# Troubleshooting
Python Exe:
If you are having trouble running the executable, try running it from a command prompt or a Powershell terminal. If it is encountering an error it will print to the terminal. You can ask for help on the discord modding channel.

Powershell script:
If you are having trouble running the script you should try doing so by opening a Powershell terminal first and then running the script. This will allow you to see any error messages that are being printed in the terminal. You can do so by doing the following:
1. Open the start menu, and type PowerShell. Select and run "Windows PowerShell".
2. Navigate to the game directory
  cd C:\Brotato_Mod_Selector
3. Run the script
  .\Brotato_Mod_Selector.ps1
  
