@echo off
chcp 65001 >nul  REM UTF-8 karakter setini etkinleştir

:: Geçerli dizine geç
cd /d "%~dp0"

:: Servis durumunu kontrol et
call service_status.bat zapret

:: Güncellemeleri kontrol et
call check_updates.bat soft
echo:

:: Bin dizinini tanımla
set BIN=%~dp0bin\

:: Zapret servisini başlat ve DPI atlatma ayarlarını uygula
start "zapret: general" /min "%BIN%winws.exe" ^
  --wf-tcp=80,443 --wf-udp=443,50000-50100 ^
  --filter-udp=443 --hostlist="list-general.txt" ^
  --dpi-desync=fake --dpi-desync-repeats=6 ^
  --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --new ^
  --filter-udp=50000-50100 --ipset="ipset-discord.txt" ^
  --dpi-desync=fake --dpi-desync-any-protocol --dpi-desync-cutoff=d3 ^
  --dpi-desync-repeats=8 --new ^
  --filter-tcp=80 --hostlist="list-general.txt" ^
  --dpi-desync=fake,split2 --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig --new ^
  --filter-tcp=443 --hostlist="list-general.txt" ^
  --dpi-desync=fake,split2 --dpi-desync-repeats=6 ^
  --dpi-desync-fooling=md5sig --dpi-desync-fake-tls="%BIN%tls_clienthello_www_google_com.bin"
