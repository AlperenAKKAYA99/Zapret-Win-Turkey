@echo off
chcp 65001 >nul  :: REM Konsol kodlamasını UTF-8 olarak ayarla

cd /d "%~dp0"  :: REM Komut dosyasının bulunduğu dizine geç

:: Servis durumunu kontrol et
call service_status.bat zapret

:: Güncellemeleri kontrol et
call check_updates.bat soft
echo:

:: Bin klasör yolunu değişkene ata
set "BIN=%~dp0bin\"

:: Zapret işlemini başlat
start "zapret: general" /min "%BIN%winws.exe" ^
  --wf-tcp=80,443 --wf-udp=443,50000-50100 ^
  --filter-udp=443 --hostlist="list-general.txt" --dpi-desync=fake ^
  --dpi-desync-repeats=6 --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --new ^
  --filter-udp=50000-50100 --ipset="ipset-discord.txt" --dpi-desync=fake ^
  --dpi-desync-any-protocol --dpi-desync-cutoff=d3 --dpi-desync-repeats=6 --new ^
  --filter-tcp=80 --hostlist="list-general.txt" --dpi-desync=fake,split2 ^
  --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig --new ^
  --filter-tcp=443 --hostlist="list-general.txt" --dpi-desync=fake ^
  --dpi-desync-autottl=2 --dpi-desync-repeats=6 --dpi-desync-fooling=badseq ^
  --dpi-desync-fake-tls="%BIN%tls_clienthello_www_google_com.bin"