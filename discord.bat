@echo off
chcp 65001 >nul
:: Kodlama: UTF-8

cd /d "%~dp0"

:: Gerekli servis durumunu kontrol et ve güncellemeleri çalıştır
call service_status.bat zapret
call check_updates.bat soft
echo.

:: Bin klasörünün yolu
set "BIN=%~dp0bin\"

:: Discord bağlantıları için filtreleme ve DPI desynchronizasyon ayarları
start "zapret: discord" /min "%BIN%winws.exe" ^
  --wf-tcp=443 ^                           :: TCP 443 üzerinden bağlantı yakala
  --wf-udp=443,50000-50100 ^                :: UDP portları: 443 ve 50000-50100
  --filter-udp=443 ^                       :: UDP 443 filtresi, listeden alınan host'lar için
  --hostlist="list-discord.txt" ^          :: Discord'a ait host'ların bulunduğu liste
  --dpi-desync=fake ^                      :: DPI desync modu: fake
  --dpi-desync-repeats=6 ^                   :: 6 defa tekrarlama
  --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" ^  :: Fake QUIC paketi
  --new ^                                  :: Yeni kural bloğu başlat
  --filter-udp=50000-50100 ^               :: UDP 50000-50100 filtresi
  --ipset="ipset-discord.txt" ^            :: Discord için IP set listesi
  --dpi-desync=fake ^                      :: DPI desync modu: fake (her protokol için)
  --dpi-desync-any-protocol ^              :: Tüm protokoller için DPI desync
  --dpi-desync-cutoff=d3 ^                 :: DPI desync cutoff: d3
  --dpi-desync-repeats=6 ^                   :: 6 defa tekrarlama
  --new ^                                  :: Yeni kural bloğu başlat
  --filter-tcp=443 ^                       :: TCP 443 filtresi, listeden alınan host'lar için
  --hostlist="list-discord.txt" ^          :: Discord host listesi
  --dpi-desync=fake,split ^                :: DPI desync modu: fake, split
  --dpi-desync-autottl=2 ^                 :: Otomatik TTL ayarı: 2
  --dpi-desync-repeats=6 ^                   :: 6 defa tekrarlama
  --dpi-desync-fooling=badseq ^            :: DPI desync fooling: badseq
  --dpi-desync-fake-tls="%BIN%tls_clienthello_www_google_com.bin"
