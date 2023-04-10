# AkademiHUB

* AkademiHUB akademi bursiyerlerinin ve moderatörlerinin,gerek motivasyon gerekse yardımlaşma amacıyla kullanabileceği bir iletişim platformudur.
* Uygulama açıldığında,backend'de firebase ile desteklediğimiz bir Authentication ekranı ve  üye olma butonu karşılıyor.Burada kaydınız yoksa, Üye ol kısmından gerekli bilgileri girerek üye olabiliyoruz.
* Anasayfa kısmında, belirli konu başlıkları altında verilen içerikler paylaşılıyor.Bu içerikler de aynı şekilde firestore temelli bir  veri tabanıyla destekleniyor.Gönderilere tıklandığında,kullanıcı başka kullanıcıların paylaştığı gönderilere yorum ekleyebilir ve beğenebilir.
* Bir kullanıcı kendi yolladığı post'un altına gelen yorumları, eğer bir sorununa çözüm olduysa, çözüm olarak işaretleyebilir.(açık yeşil olarak belirtiliyor.) Bu özellik için sahibi olduğu post'un altındaki ilgili yoruma dokunması yeterli.
* Anasayfanın yanında bulunan "Gönderi" sayfasında,kullanıcı kendi gönderisini oluşturarak paylaşabiliyor. Bu bölümün en güzel yanlarından biri de,gönderilerin sınıflandırılması amacıyla konu kategori tiplerinin seçilmesi opsiyonu.
* Hemen yanında bulunan "Liderlik Tablosu" bölümündeyse,akademi bursiyerlerinin derslerdeki ilerlemeleri,yanıtladıkları sorular,aldıkları beğeniler gibi faktörlerden elde edilen puanlarla göre oluşturulmuş bir liderlik tablosu bulunuyor.Diğer özellikler gibi,bu bilgiler de Firebase tarafında tutulan verilerden elde ediliyor.
* En sonda ise Kullanıcının,kendi ismini,derslerindeki ilerlemelerini ve Akademi Puanı gibi kişisel bilgilerini gösteren bir "Hesabım" sayfası bulunuyor.

# Akademi Puanı Algoritması
* Akdemi Puanı (AP) kazanmanın 4 yolu mevcuttur:
1. Akademi eğitimlerinin tamamlanma yüzdesine göre -> Tamamladığınız yüzdelik * 20 olarak puanınıza ekleniyor.
2. Bir post'unuzun beğenilmesi sonucu puan kazanabilirsiniz. -> Aldığınız bir beğeni size 10 puan getirir.
3. Bir postun altına attığınız yorumun beğenilmesi -> Aldığınız her bir yorum beğenisi size 5 puan kazandırır.
4. Bir sorun postunun altına attığınız yorumun çözüm olarak işaretlenmesi -> Bir yorumunuzun çözüm olarak işaretlenmesi size 20 puan kazandırır.

## Notlar:
* Olur da bir gün akademi bu uygulamayı kullanmak isterse en iyi kullanıcı deneyimi için kazanılan puanlara ve liderlik tablosundaki durumlara göre bursiyerleri ödüllendirebilir.
* Ders ilerlemeleri her kullanıcı için kayıt olma aşamasında rastgele olarak atanıyor. Normalde gerekli izinler sağlandığında bu bilgiler bir backend tarafından sağlanabilir.
* Moderatör hesabı olarak akademi için oluşturduğumuz hesap: email: `oua@gmail.com` , şifre: `12345678` (Mavi tikli hesap), eğer daha fazla moderatör hesabı istenirse manuel şekilde yetkilendirme yapılması gerekiyor. Firestore'da `users` collection'unda istenilen User'da `isUserModerator` field'ı `true` yapılırsa kullanıcıya moderatör yetkisi veriliyor. (Uygulama ilerletilirse basit bir admin paneliyle bu işlemler daha kolay hale gelebilir.)
* TopBar'daki kategori etiketleri oluşturulurken, listedeki mevcut postların kategorileri kullanılıyor.
* Uygulamayı 3 kullanıcıdan az kullanıcı kullanıyorsa liderlik tablosunda bazı hatalar oluşabilir. En iyi deneyim için mevcut firebase ile kullanımı öneriyoruz. 
* Moderatör hesaplarının profil sayfası diğer kullanıcılardan farklı şekilde görüntüleniyor ve puan tablosunda yer almıyorlar.

## Firestore Yapısı:

* Comments:

  ![firestore1](https://user-images.githubusercontent.com/93993257/230802204-02f3974f-a239-4408-8dc7-ed3a0e1bd430.PNG)

* Posts:

  ![firestore2](https://user-images.githubusercontent.com/93993257/230802211-27b8525d-e734-4064-a30b-571516dfdd5f.PNG)

* Users:

  ![firestore3](https://user-images.githubusercontent.com/93993257/230802220-50581fd8-4b51-48b0-8d1d-7498182edb07.PNG)
