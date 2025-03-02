@echo off
chcp 65001 >nul
:: 65001 - UTF-8 karakter setini kullan

cd /d "%~dp0"
:: Script'in bulunduğu dizine geçiş yap

call service_status.bat zapret
:: 'service_status.bat' dosyasını çağırarak 'zapret' parametresi ile çalıştır

call check_updates.bat soft
:: 'check_updates.bat' dosyasını çağırarak 'soft' parametresi ile çalıştır

echo:
:: Boş bir satır ekle

set BIN=%~dp0bin\
:: 'bin' klasörünün yolunu %BIN% değişkenine at

:: Başlatma işlemi, tüm parametreler tek bir satıra indirildi
start "zapret: general" /min "%BIN%winws.exe" --wf-tcp=80,443 --wf-udp=443,50000-50100 ^
--filter-udp=443 --hostlist="list-general.txt" --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --new ^
--filter-udp=50000-50100 --ipset="ipset-discord.txt" --dpi-desync=fake --dpi-desync-any-protocol --dpi-desync-cutoff=d3 --dpi-desync-repeats=6 --new ^
--filter-tcp=80 --hostlist="list-general.txt" --dpi-desync=fake,split2 --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig --new ^
--filter-tcp=443 --hostlist="list-general.txt" --dpi-desync=fake,split --dpi-desync-autottl=2 --dpi-desync-repeats=6 --dpi-desync-fooling=badseq --dpi-desync-fake-tls="%BIN%tls_clienthello_www_google_com.bin"
:: 'winws.exe' programını başlat ve parametreleri çalıştır. Parametreler:
:: - TCP ve UDP protokollerini belirli portlarla açma
:: - 'list-general.txt' dosyasındaki host listesine filtreleme
:: - DPI desynchronization ayarları (fake, split, fake-quic vb.)
:: - TLS client hello için fake bin dosyası
