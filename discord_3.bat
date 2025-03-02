@echo off
chcp 65001 >nul  :: UTF-8 kodlama desteği sağlar

:: Komut dosyasının bulunduğu dizine geç
cd /d "%~dp0"

:: Servis durumunu kontrol et ve güncellemeleri denetle
call service_status.bat zapret
call check_updates.bat soft
echo:

:: Bin dizinini ayarla
set BIN=%~dp0bin\

:: zapret başlatma komutu (Gizli pencere modunda çalıştır)
start "zapret: general" /min "%BIN%winws.exe" ^
  --wf-tcp=80,443 --wf-udp=443,50000-50100 ^
  --filter-udp=443 --hostlist="list-general.txt" --dpi-desync=fake --dpi-desync-repeats=6 ^
  --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --new ^
  --filter-udp=50000-50100 --ipset="ipset-discord.txt" --dpi-desync=fake --dpi-desync-any-protocol ^
  --dpi-desync-cutoff=d3 --dpi-desync-repeats=6 --new ^
  --filter-tcp=80,443 --hostlist="list-general.txt" --dpi-desync=split,split2 ^
  --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig,badseq --dpi-desync-repeats=8