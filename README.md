# Eğitim Amaçlı Proje

Bu proje, yazılım ve ağ güvenliği tekniklerinin eğitim amaçlı kullanımını sağlamak için geliştirilmiştir. Eğitim, araştırma ve geliştirme amaçlarıyla kullanılabilir. Ancak, yazılımın kullanımıyla ilgili yasal sorumluluk tamamen kullanıcıya aittir.

## İşlevsellik

Ağ güvenliği tekniklerini anlamak için tasarlanmış bu proje, ağ protokollerini analiz etme ve veri akışını yönlendirme gibi işlevselliklere sahiptir.


## Parametre Kullanım Kılavuzu

Aşağıda, projenizde kullanabileceğiniz parametreler, alabilecekleri değer aralıkları ve işlevleri yer almaktadır:

| **Parametre**                                      | **İşlev**                                                                                  | **Değer Aralığı / Örnekler**                                            |
|----------------------------------------------------|--------------------------------------------------------------------------------------------|-------------------------------------------------------------------------|
| `--wf-tcp=<port1>,<port2>`                         | TCP protokolü üzerinden belirtilen portları izler.                                          | `<port1>`, `<port2>`: 1-65535 (Örneğin: `--wf-tcp=80,443`)            |
| `--wf-udp=<port1>,<port2>-<port3>`                 | UDP protokolü üzerinden belirtilen portları izler.                                          | `<port1>`, `<port2>`, `<port3>`: 1-65535 (Örneğin: `--wf-udp=443,50000-50100`) |
| `--filter-udp=<port>`                               | Belirtilen UDP portu üzerinden gelen trafiği filtreler.                                      | `<port>`: 1-65535 (Örneğin: `--filter-udp=443`)                        |
| `--hostlist="<dosya_adı>"`                          | Belirtilen dosyadaki host isimlerini kullanır.                                               | `<dosya_adı>`: Dosya yolu (Örneğin: `--hostlist="list-general.txt"`)   |
| `--dpi-desync=<değer>`                             | DPI (Derin Paket İncelemesi) uyumsuzluğunu taklit eder.                                      | `<değer>`: `fake`, `none` (Örneğin: `--dpi-desync=fake`)              |
| `--dpi-desync-repeats=<sayı>`                      | DPI uyumsuzluğunun belirtilen sayıda tekrarlanmasını sağlar.                                | `<sayı>`: Pozitif tam sayı (Örneğin: `--dpi-desync-repeats=6`)         |
| `--dpi-desync-fake-quic="<dosya_adı>"`             | QUIC protokolü için sahte bir başlangıç paketi kullanır.                                      | `<dosya_adı>`: Dosya yolu (Örneğin: `--dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin"`) |
| `--new`                                            | Yeni bir işlem başlatır.                                                                     | Değer almaz, parametre yalnızca etkinleştirir.                          |
| `--filter-udp=<port1>-<port2>`                     | UDP portları arası trafiği filtreler.                                                       | `<port1>`, `<port2>`: 1-65535 (Örneğin: `--filter-udp=50000-50100`)   |
| `--ipset="<dosya_adı>"`                            | Belirtilen dosyadaki IP adreslerini kullanır.                                                | `<dosya_adı>`: Dosya yolu (Örneğin: `--ipset="ipset-discord.txt"`)     |
| `--dpi-desync-any-protocol`                        | Herhangi bir protokol için DPI uyumsuzluğunu etkinleştirir.                                   | Değer almaz, parametre yalnızca etkinleştirir.                          |
| `--dpi-desync-cutoff=<değer>`                      | DPI uyumsuzluğu için kesilme değerini ayarlar.                                               | `<değer>`: `d1`, `d2`, `d3` (Örneğin: `--dpi-desync-cutoff=d3`)       |
| `--dpi-desync-autottl=<sayı>`                      | Otomatik TTL (Time To Live) değerini ayarlar.                                               | `<sayı>`: 1-255 (Örneğin: `--dpi-desync-autottl=2`)                    |
| `--dpi-desync-fooling=<değer>`                     | MD5 imzası ile DPI'yi kandırmaya çalışır.                                                   | `<değer>`: `md5sig` (Örneğin: `--dpi-desync-fooling=md5sig`)           |
| `--dpi-desync-fake-tls="<dosya_adı>"`              | TLS el sıkışması için sahte bir paket kullanır.                                              | `<dosya_adı>`: Dosya yolu (Örneğin: `--dpi-desync-fake-tls="%BIN%tls_clienthello_www_google_com.bin"`) |
| `--dpi-desync-split-seqovl=<değer>`                | Bölünmüş sıralama numarası örtüşmesini ayarlar.                                              | `<değer>`: Pozitif tam sayı (Örneğin: `--dpi-desync-split-seqovl=652`) |
| `--dpi-desync-split-pos=<değer>`                   | Bölünmüş paketlerin konumunu ayarlar.                                                       | `<değer>`: Pozitif tam sayı (Örneğin: `--dpi-desync-split-pos=2`)      |
| `--dpi-desync-split-seqovl-pattern="<dosya_adı>"`  | Bölünmüş paketler için sıralama numarası örtüşme desenini belirler.                          | `<dosya_adı>`: Dosya yolu (Örneğin: `--dpi-desync-split-seqovl-pattern="%BIN%tls_clienthello_www_google_com.bin"`) |

## Kullanım Örnekleri
### 1. TCP Port İzleme
--wf-tcp=80,443
### 2. UDP Port Filtreleme
--filter-udp=50000-50100
### 3. DPI Uyumsuzluğu Taklit Etme
--dpi-desync=fake --dpi-desync-repeats=6
### 4. IP Seti Kullanma
--ipset="ipset-discord.txt"
## Daha Fazla Bilgi
   Daha fazla bilgi kazanmak için projenin (Hazır - Kullanım) dosyalarını inceleye bilrisiniz...

## Hazır - Kullanım
1. **Arşivi İndirin**: Son sürüm arşivini [buradan indirin](https://github.com/AlperenAKKAYA99/Zapret-Win-Turkey/releases/latest).
2. **Arşivi Çıkartın**: Dosyaları bir klasöre çıkarın. Dosya yolunda özel karakterler veya Türkçe harfler olmamalıdır.
3. **İlgili Dosyayı Çalıştırın**: İhtiyacınıza uygun `.bat` dosyasını çalıştırın:
   - **`discord.bat`**: Discord blokajlarını aşmak için.
   - **`discord_1.bat`**: Alternatif Discord blokaj aşma yöntemi-1.
   - **`discord_2.bat`**: Alternatif Discord blokaj aşma yöntemi-2.
   - **`discord_3.bat`**: Alternatif Discord blokaj aşma yöntemi-3.
   - **`discord_4.bat`**: Alternatif Discord blokaj aşma yöntemi-4.
   - **`discord_5.bat`**: Alternatif Discord blokaj aşma yöntemi-5 **(Önerilen_DC)**.
   - **`general.bat`**: Genel Discord blokaj aşma.
   - **`general (Superonline).bat`**: Superonline kullanıcıları için alternatif.
   - **`general (Superonline_2).bat`**: Superonline_2 kullanıcıları için alternatif.

Proje ayrıca şu dosyaları içerir:
- **`service_install.bat`**: Windows hizmetleri olarak Zapret ve WinDivert'i yükler.
- **`service_remove.bat`**: Yüklenen hizmetleri kaldırır.
- **`check_updates.bat`**: Güncellemeleri kontrol eder.

## Yasal Uyarılar

**Bu yazılım yalnızca eğitim amaçlıdır.** Aşağıdaki şartlar geçerlidir:
- Yazılım yalnızca kişisel, eğitim ve araştırma amaçları için kullanılmalıdır.
- Yazılımın kullanımı yerel yasalarınıza aykırı olabilir. Yazılımı kullanmadan önce yerel yasalara uygunluğunu kontrol etmelisiniz.
- Yazılım yalnızca yasal ve etik sınırlar içinde kullanılmalıdır.
- Yazılımın kötüye kullanımı sonucu oluşacak zararlardan proje sahibi sorumlu değildir.

**Sorumluluk Reddi:** Projenin kullanımından doğacak tüm yasal sorumluluk kullanıcıya aittir. Yazılımın kötü amaçlı kullanımı, yasa dışı faaliyetlere dahil olunması veya başkalarının haklarının ihlali durumunda proje geliştiricileri sorumluluk kabul etmez.

## Destek

Projenin desteklenmesi için GitHub sayfasını takip edebilir veya katkıda bulunabilirsiniz:
- GitHub: [AlperenAKKAYA99/Zapret-Win-Turkey](https://github.com/AlperenAKKAYA99/Zapret-Win-Turkey)

## Lisans

Bu proje, [MIT Lisansı](https://opensource.org/licenses/MIT) ile lisanslanmıştır.

## Atıf ve Kaynaklar

- [bol-van/zapret](https://github.com/bol-van/zapret)
- [basil00/WinDivert](https://github.com/basil00/WinDivert)
- [elitrao/zapret-winws](https://github.com/elitrao/zapret-winws)
