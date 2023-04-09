# AkademiHUB

* AkademiHUB akademi bursiyerlerinin ve moderatörlerinin,gerek motivasyon gerekse yardımlaşma amacıyla kullanabileceği bir iletişim platformudur.
* Uygulama açıldığında,backend'de firebase ile desteklediğimiz bir Authentication ekranı ve  üye olma butonu karşılıyor.Burada kaydınız yoksa, Üye ol kısmından gerekli bilgileri girerek üye olabiliyoruz.
* Anasayfa kısmında, belirli konu başlıkları altında verilen içerikler paylaşılıyor.Bu içerikler de aynı şekilde firestore temelli bir  veri tabanıyla destekleniyor.Gönderilere tıklandığında,kullanıcı başka kullanıcıların paylaştığı gönderilere yorum ekleyebilir ve beğenebilir.
* Bir kullanıcı kendi yolladığı post'un altına gelen yorumları, eğer bir sorununa çözüm olduysa, çözüm olarak işaretleyebilir.(açık yeşil olarak belirtiliyor.)
* Anasayfanın yanında bulunan "Gönderi" sayfasında,kullanıcı kendi gönderisini oluşturarak paylaşabiliyor. Bu bölümün en güzel yanlarından biri de,gönderilerin sınıflandırılması amacıyla konu kategori tiplerinin seçilmesi opsiyonu.
* Hemen yanında bulunan "Liderlik Tablosu" bölümündeyse,akademi bursiyerlerinin derslerdeki ilerlemeleri,yanıtladıkları sorular,aldıkları beğeniler gibi faktörlerden elde edilen puanlarla göre oluşturulmuş bir liderlik tablosu bulunuyor.Diğer özellikler gibi,bu bilgiler de Firebase tarafında tutulan verilerden elde ediliyor.
* En sonda ise Kullanıcının,kendi ismini,derslerindeki ilerlemelerini ve Akademi Puanı gibi kişisel bilgilerini gösteren bir "Hesabım" sayfası bulunuyor.

## Notlar:
* Ders ilerlemeleri her kullanıcı için kayıt olma aşamasında rastgele olarak atanıyor. Normalde gerekli izinler sağlandığında bu bilgiler bir backend tarafından sağlanabilir.
* Moderatör hesabı olarak akademi için oluşturduğumuz hesap: email: `oua@gmail.com` , şifre: `12345678` (Mavi tikli hesap), eğer daha fazla moderatör hesabı istenirse manuel şekilde yetkilendirme yapılması gerekiyor. Firestore'da `users` collection'unda istenilen User'da `isUserModerator` field'ı `true` yapılırsa kullanıcıya moderatör yetkisi veriliyor. (Uygulama ilerletilirse basit bir admin paneliyle bu işlemler daha kolay hale gelebilir.)