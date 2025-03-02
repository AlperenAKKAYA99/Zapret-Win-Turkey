@echo off
chcp 65001 >nul
:: 65001 - UTF-8 karakter seti kullanımı

cd /d "%~dp0"
:: Bulunduğunuz dizini geçerli dizin olarak ayarlayın

call service_status.bat zapret
call check_updates.bat soft
:: Durum kontrolü ve güncellemeleri denetleme işlemleri

echo:

set BIN=%~dp0bin\
:: Bin dizininin yolu olarak %~dp0bin\ kullanılacak

:: Başlangıç parametreleri
start "zapret: general" /min "%BIN%winws.exe" ^
  --wf-tcp=80,443 --wf-udp=443,50000-50100 ^
  --filter-udp=443 --hostlist="list-general.txt" --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --new ^
  --filter-udp=50000-50100 --ipset="ipset-discord.txt" --dpi-desync=fake --dpi-desync-any-protocol --dpi-desync-cutoff=d3 --dpi-desync-repeats=6 --new ^
  --filter-tcp=80 --hostlist="list-general.txt" --dpi-desync=fake,split2 --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig --new ^
  --filter-tcp=443 --hostlist="list-general.txt" --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fooling=md5sig --dpi-desync-fake-tls="%BIN%tls_clienthello_www_google_com.bin"
:: Burada 'winws.exe' başlatılıyor ve ağ filtreleme, DPI manipülasyonu gibi birçok parametre ile çalıştırılıyor.
