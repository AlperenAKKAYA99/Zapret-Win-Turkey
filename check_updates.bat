@echo off
setlocal EnableDelayedExpansion
chcp 437 > nul

set "CURRENT_VERSION=1.0.0"
set "GITHUB_URL=https://raw.githubusercontent.com/AlperenAKKAYA99/Zapret-Win-Turkey/refs/heads/main/version.txt"
set "RELEASE_URL=https://github.com/AlperenAKKAYA99/Zapret-Win-Turkey/releases/latest"
set "VERSION_FILE=version.txt"
set "SKIP_VERSION=null"
set "FILE_EXISTS=1"

for /f "delims=" %%A in ('powershell -command "[datetime]::Now.ToString('yyyy-MM-dd HH:mm:ss')"') do set CURRENT_TIMESTAMP=%%A

:: Eğer version.txt dosyası yoksa
if not exist %VERSION_FILE% (
    set "FILE_EXISTS=0"
    echo time: %CURRENT_TIMESTAMP%> %VERSION_FILE%
    echo ver: %CURRENT_VERSION%>> %VERSION_FILE%
)

:: Yerel version.txt dosyasından veri okuma
for /f "tokens=1,* delims=: " %%A in (%VERSION_FILE%) do (
    if "%%A"=="time" set "LAST_CHECK=%%B"
    if "%%A"=="ver" set "INSTALLED_VERSION=%%B"
    if "%%A"=="skip" set "SKIP_VERSION=%%B"
)

:: Eğer dosya üçüncü taraf bir script tarafından çağrıldıysa (12 saatlik kontrol engelleme ile 'soft' parametresi ile)
if "%~1"=="soft" (
    :: Tarihleri parçalara ayırarak hesaplama yapma
    for /f "tokens=1-6 delims=-: " %%A in ("%CURRENT_TIMESTAMP%") do (
        set "CURRENT_MONTH=%%B"
        set "CURRENT_DAY=%%C"
        set "CURRENT_HOUR=%%D"
    )
    for /f "tokens=1-6 delims=-: " %%A in ("%LAST_CHECK%") do (
        set "LAST_MONTH=%%B"
        set "LAST_DAY=%%C"
        set "LAST_HOUR=%%D"
    )

    set /a "time_diff_in_minutes = (CURRENT_MONTH - LAST_MONTH) * 43200 + (CURRENT_DAY - LAST_DAY) * 1440 + (CURRENT_HOUR - LAST_HOUR) * 60"

    if !time_diff_in_minutes! LEQ 360 if !FILE_EXISTS!==1 (
        echo Guncelleme kontrolu 6 saat icinde yapilmadi, atlaniyor.
        goto :EOF
    )
)

:: Yeni sürümü GitHub'dan okuma
set "NEW_VERSION="
for /f "delims=" %%A in ('powershell -command "(Invoke-WebRequest -Uri %GITHUB_URL% -Headers @{\"Cache-Control\"=\"no-cache\"} -TimeoutSec 5).Content" 2^>nul') do set "NEW_VERSION=%%A"
if not defined NEW_VERSION (
    echo Yeni surum okunurken hata olustu
    goto :EOF
)

:: Dosyayı yeniden yazma
echo time: %CURRENT_TIMESTAMP%> %VERSION_FILE%
echo ver: %INSTALLED_VERSION%>> %VERSION_FILE%
echo skip: %SKIP_VERSION%>> %VERSION_FILE%

:: Sürümleri karşılaştırma
if "%NEW_VERSION%"=="%INSTALLED_VERSION%" (
    echo En son surum olan %NEW_VERSION% kullaniyorsunuz.
    goto :EOF
) else (
    :: Sürüm atlandıysa kontrol et
    if "%NEW_VERSION%"=="%SKIP_VERSION%" (
        echo Kullanici tarafindan atlanan yeni surum %NEW_VERSION%.
        goto :EOF
    ) else (
        echo Yeni surum bulundu: %NEW_VERSION%.
        echo Yeni surumu indirmek icin %RELEASE_URL%'yi ziyaret edin.
    )
)

:: Güncellemeyi atla
set /p "CHOICE=Bu guncellemeyi atlamak ister misiniz? (y/n, varsayilan: n): " || set "CHOICE=n"
set "CHOICE=!CHOICE:~0,1!"
if /i "!CHOICE!"=="y" (
    echo skip: %NEW_VERSION%>> %VERSION_FILE%
    echo %NEW_VERSION% surumu atlandi.
) else (
    start %RELEASE_URL%
)

endlocal
