import os
import subprocess
import json
import time
from winreg import *
import tkinter
from tkinter import filedialog

defaultPackDirStr = os.getcwd() + "\packs"
defaultBrotatoSteamAppIdStr = "1942280"
configFileStr= os.getcwd() + "\Brotato_Mod_Selector.json"

# Get the current Steam install path from the registry
aReg = ConnectRegistry(None, HKEY_LOCAL_MACHINE)
steamInstallPathStr = ""
try:
    aKey = OpenKey(aReg, r"SOFTWARE\WOW6432Node\Valve\Steam")
    steamInstallPathStr = QueryValueEx(aKey, "InstallPath")[0]
except:
    try:
        aKey = OpenKey(aReg, r"SOFTWARE\Valve\Steam")
        steamInstallPathStr = QueryValueEx(aKey, "InstallPath")[0]
    except:
        print("Steam path not found in registry. Is it installed?")
        exit(1)

steamExeStr = steamInstallPathStr + "\Steam.exe"
packDirStr = defaultPackDirStr
brotatoSteamAppId = defaultBrotatoSteamAppIdStr

# Load the json config file if it exists
if os.path.exists(configFileStr):
    with open(configFileStr, "r") as jsonfile:
        configFileData = json.load(jsonfile)

    if configFileData['ModPackPath'] != "":
        packDirStr = configFileData['ModPackPath']
    if configFileData['BrotatoSteamAppId'] != "":
        brotatoSteamAppId = configFileData['BrotatoSteamAppId']

# Have user select mod pack
root = tkinter.Tk()
root.withdraw()
print("--- Select the modded Brotato pck file to use ---")
modPack = filedialog.askopenfilename(initialdir=packDirStr)
modPackPath = os.path.dirname(modPack)

# Launch Brotato
if modPack != "":
    jsonConfig = {
        "ModPackPath" : f"{modPackPath}",
        "BrotatoSteamAppId" : f"{brotatoSteamAppId}"
    }
    with open(configFileStr, "w") as jsonfile:
        json.dump(jsonConfig, jsonfile)

    print("Launching Brotato...")
    ret = subprocess.call([steamExeStr, "-applaunch", "1942280", "--main-pack", modPack])
    print("Brotato launched!")
    print("Note: It sometimes takes Steam a while to load the game. Check your task manager if you don't see the game come up.")
    time.sleep(60)
    
