# Daily Kit Standalone

Bu script, FiveM sunucusunda **Ox Inventory** ve **oxmysql** kullanarak oyunculara günlük bir kit vermek için hazırlanmıştır. Komut bazlı çalışır ve her oyuncu için 24 saatlik bir cooldown uygular.

## Özellikler

- `gunlukit` komutu ile kit alma
- Her oyuncu için 24 saatlik tekrar alma bekleme süresi
- Ox Inventory ile taşıma kontrolü
- Ox Lib bildirimleri ile kullanıcıya durumu gösterme
- MySQL veritabanında son alım zamanını saklama

## Gereksinimler

- FiveM sunucusu
- `oxmysql`
- `ox_inventory`
- `ox_lib` (bildirimler için önerilir)

## Kurulum

1. `alis-gunlukit` klasörünü sunucu kaynakları dizinine kopyalayın.
2. `server.cfg` içine aşağıdaki satırları ekleyin:

```cfg
ensure alis-gunlukit
```

3. MySQL veritabanınıza aşağıdaki tabloyu ekleyin:

```sql
CREATE TABLE IF NOT EXISTS `daily_kits_standalone` (
    `identifier` VARCHAR(60) NOT NULL,
    `last_claim` INT(11) NOT NULL,
    PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

## Kullanım

Oyuncular oyunda chat veya komut paneline aşağıdaki komutu yazar:

```txt
/gunlukit
```

Komutu kullanan oyuncu, 24 saat içinde daha önce kit almışsa kalan süre hakkında bilgilendirilir.

## Ayarlar

`server.lua` dosyasında kolayca değiştirilebilen ayarlar:

- `KIT_ITEM`: Verilecek item adı. Örnek: `bread`, `water`, `bandage`
- `KIT_ADET`: Verilecek adet sayısı
- `COOLDOWN`: Bekleme süresi (saniye cinsinden). Varsayılan 24 saat = `86400`

## Nasıl çalışır

1. Oyuncu `/gunlukit` komutunu kullanır.
2. Sunucu oyuncunun `license` identifierını alır.
3. MySQL tablosundan `last_claim` kontrol edilir.
4. Eğer cooldown tamamlanmadıysa, kalan süre oyuncuya bildirilir.
5. Eğer cooldown tamamlandıysa, oyuncunun envanterine belirlenen kit verilir ve `last_claim` güncellenir.

## Notlar

- `ox_lib` bildirim modülü yüklü değilse, komut yine çalışır ama bildirimler gönderilmez.
- `ox_inventory:CanCarryItem` fonksiyonu ile envanter kapasitesi kontrol edilir.
- `identifier` olarak `license` kullanıldığı için her oyuncu benzersiz bir şekilde takip edilir.

## Lisans

Bu proje açık kaynak amaçlıdır. Dilediğiniz gibi değiştirip kullanabilirsiniz.

## Destek

🚀 Developed by AliSDEV

Kaliteli FiveM scriptleri, özel sistemler ve geliştirme desteği için iletişime geçebilirsiniz.

Discord: alis35

Herhangi bir hata alırsanız `F8` konsolunu ve sunucu konsolunu kontrol etmeyi unutmayın.
```
