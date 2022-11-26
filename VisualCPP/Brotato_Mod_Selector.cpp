// Brotato_Mod_Selector.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include <windows.h>

std::wstring GetPckFileName()
{
    OPENFILENAME    ofn;
    const wchar_t* FilterSpec = L"Brotato pck File(*.pck)\0*.pck\0All Files(*.*)\0*.*\0";
    const wchar_t* Title = L"Open....";
    wchar_t szFileName[MAX_PATH] = {0};
    wchar_t szFileTitle[MAX_PATH] = {0};
    int Result = 0;
    wchar_t filePath[MAX_PATH] = {0}; // Selected file and path

    *szFileName = 0;
    *szFileTitle = 0;

    /* fill in non-variant fields of OPENFILENAME struct. */
    ofn.lStructSize = sizeof(OPENFILENAME);
    ofn.hwndOwner = GetFocus();
    ofn.lpstrFilter = FilterSpec;
    ofn.lpstrCustomFilter = NULL;
    ofn.nMaxCustFilter = 0;
    ofn.nFilterIndex = 0;
    ofn.lpstrFile = szFileName;
    ofn.nMaxFile = MAX_PATH;
    ofn.lpstrInitialDir = L"."; // Initial directory.
    ofn.lpstrFileTitle = szFileTitle;
    ofn.nMaxFileTitle = MAX_PATH;
    ofn.lpstrTitle = Title;
    ofn.lpstrDefExt = L".pck";

    ofn.Flags = OFN_FILEMUSTEXIST | OFN_HIDEREADONLY;

    if (!GetOpenFileName((LPOPENFILENAME)&ofn))
    {
        return L""; // Failed or cancelled
    }
    const rsize_t filePathLen = sizeof(filePath) / sizeof(filePath[0]);
    wcsncpy_s(filePath, filePathLen, ofn.lpstrFile, filePathLen-1);
    std::wstring wfilePathStr(filePath);
    return wfilePathStr;
}

LONG GetStringRegKey(HKEY hKey, const std::wstring& strValueName, std::wstring& strValue, const std::wstring& strDefaultValue)
{
    strValue = strDefaultValue;
    WCHAR szBuffer[512];
    DWORD dwBufferSize = sizeof(szBuffer);
    ULONG nError;
    nError = RegQueryValueEx(hKey, strValueName.c_str(), 0, NULL, (LPBYTE)szBuffer, &dwBufferSize);
    if (ERROR_SUCCESS == nError)
    {
        strValue = szBuffer;
    }
    return nError;
}

std::wstring GetSteamExeLocation()
{
    HKEY hKey;
    LONG lRes = RegOpenKeyEx(HKEY_LOCAL_MACHINE, L"SOFTWARE\\WOW6432Node\\Valve\\Steam", 0, KEY_READ, &hKey);
    if (lRes == ERROR_FILE_NOT_FOUND)
    {
        lRes = RegOpenKeyEx(HKEY_LOCAL_MACHINE, L"SOFTWARE\\Valve\\Steam", 0, KEY_READ, &hKey);
    }
    if (lRes != ERROR_SUCCESS)
    {
        return L"";
    }

    std::wstring strValueOfBinDir;
    std::wstring strKeyDefaultValue;
    GetStringRegKey(hKey, L"InstallPath", strValueOfBinDir, L"");
    return strValueOfBinDir + L"\\Steam.exe";
}

int main()
{
    std::cout << "--- Select the modded Brotato pck file to use ---\n";
    std::wstring wModPckStr = GetPckFileName();
    std::wstring wSteamExeStr = GetSteamExeLocation();
    if (wModPckStr != L"" && wSteamExeStr != L"")
    {
        std::string modPckStr(wModPckStr.begin(), wModPckStr.end());
        std::string steamExeStr(wSteamExeStr.begin(), wSteamExeStr.end());
        char cmd[256] = {0};
        snprintf(cmd, sizeof(cmd)-1, "\"\"%s\" -applaunch 1942280 --main-pack \"%s\"\"", steamExeStr.c_str(), modPckStr.c_str());
        
        std::cout << "Executing command: " << cmd << std::endl;
        system(cmd);
    }

}
