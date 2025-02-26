import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}


class _AnasayfaState extends State<Anasayfa> {
  var sayac =0;

  @override
  void initState() { // il çalışan fonskiyonumuzun içine tezt fonksiyonumuz koyduk
    super.initState();
   // test();
    sayac_kontrol();
  }

  Future<void> sayac_kontrol() async{
    var sp = await SharedPreferences.getInstance();
    sayac = sp.getInt("sayac") ?? 0;
    setState(() { // setstate ile build tekrar güncellenir ve bizim buildimiz tekarra çalışır ve bu şekilde güncel syac değerimiz görmüş olurz
      sayac = sayac+1; // setstate ile sayacaımızı bir arttırıyoruz ve sayac değerimizi güncelliyoruz
    });
    sp.setInt("sayac", sayac); // burda da sayacımızı kaydediyoruz ve bir sonraki ekran açışımızda o sayacın üstüne ekleyerek ilerliyoruz
  }


  Future<void> test() async { // burda test adında bir fonksiyonumuzu oluşturduk
    var sp = await SharedPreferences.getInstance(); // sp adında nesnemizi oluşturduk

    // Veri Kaydı
    sp.setString("ad", "Ahmet"); // setString ile sp nesnemize değer atadım
    sp.setInt("yas", 23);
    sp.setDouble("boy", 1.50);
    sp.setBool("bekar", true);

    var arkadas_listesi =<String>[]; // sadece string türünden oluşan bir liste
    arkadas_listesi.add("Ali");
    arkadas_listesi.add("Ece");
    sp.setStringList("arkadaslistesi", arkadas_listesi);
    // Veri Silme
    sp.remove("ad"); // burda da key=ad olan keyimizi siliyoruz

    // Veri Okuma
    String gelenAd = sp.getString("ad") ?? "isim yok" ; // getString ile gelen veriyi okuyoruz print ile yazıdrıyoruz ?? bunu koyamamızın sebebi ise key'imizin bir value'su yoksa bize isim yok şekllinde gözükecek
    int gelenYas = sp.getInt("yas") ?? 0 ;
    double gelenBoy = sp.getDouble("boy") ?? 0.0 ;
    bool gelenBekar = sp.getBool("bekar") ?? false ;
    print("Gelen Ad : $gelenAd");
    print("Gelen Yaş: $gelenYas");
    print("Gelen Boy: $gelenBoy");
    print("Gelen Bekar: $gelenBekar");

    var gelenArkadasListesi = sp.getStringList("arkadas_listesi") ?? null;
    // burda arkasa listemizi vermezse boş versin diye null yazdık

    if(gelenArkadasListesi !=null){
      for(var a in gelenArkadasListesi){
        print("Arkadaş : $a");
      }
    }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Shared Preferences"),),
      body: Center(
        child: Column(
          children: [
            Text("Açılış Sayısı $sayac", style: TextStyle(fontSize: 50),)
          ],
        ),
      ),
    );
  }
}
