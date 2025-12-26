Set objShell = CreateObject("WScript.Shell")

' 獲取 runScript.vbs 文件所在的資料夾路徑
Set objFSO = CreateObject("Scripting.FileSystemObject")
strScriptPath = objFSO.GetParentFolderName(WScript.ScriptFullName)

' 使用相對路徑來指向 networkSMB.ps1
strPSScript = strScriptPath & "\networkSMB.ps1"

' 執行 PowerShell 腳本，並隱藏命令提示字元窗口
objShell.Run "powershell -WindowStyle Hidden -ExecutionPolicy Bypass -File """ & strPSScript & """", 0, False
