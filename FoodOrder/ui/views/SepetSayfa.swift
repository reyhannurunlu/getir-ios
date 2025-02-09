//
//  SepetSayfaViewController.swift
//  FoodOrder
//
//  Created by Reyhan Nur Ünlü on 22.12.2024.
//

import UIKit
import Kingfisher
import Alamofire


class SepetSayfa: UIViewController {
    
    @IBOutlet weak var labelSepetToplamDeger: UILabel!
    
    @IBOutlet weak var labelSepetToplam: UILabel!
    
    @IBOutlet weak var yemeklerTableView: UITableView!
    
    var viewModel = SepetSayfaViewModel()
    var cartContent = Yemekler()
    var yemekListesi = [SepetYemekler]()
    var sepetYemek = SepetYemekler()
    var detayViewModel = DetaySayfaViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("geçtiDIDLOAD")

   
        yemeklerTableView.delegate = self
        yemeklerTableView.dataSource = self
        
      /* NotificationCenter.default.addObserver(self, selector: #selector(yemekSepeteEklendi(_:)), name: NSNotification.Name("SepeteYemekEkle"), object: nil) */

        
        
        _ = viewModel.sepetYemeklerListesi.subscribe(onNext: { [weak self] liste in
              guard let self = self else { return }
              self.yemekListesi = liste

              // Aynı yemekleri birleştir
              self.yemekListesi = self.gruplanmisYemekListesiOlustur()

              DispatchQueue.main.async {
                  self.yemeklerTableView.reloadData()
                  self.hesaplaToplamTutar()
                
                print("geçti22")
                
            }
        })
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        viewModel.yemekleriYukle()
        
        super.viewWillAppear(animated)
        
        viewModel.sepetiGetir(kullanici_adi: "reyhan")
        
        DispatchQueue.main.async {
              self.yemeklerTableView.reloadData() // TableView'ı güncelle
              self.hesaplaToplamTutar() // Yeni toplamı hesapla
          }
      
        print("geçti33")
        
    }
    
    /* 📌 Sepete yeni bir yemek eklenince burası çalışacak
       @objc func yemekSepeteEklendi(_ notification: Notification) {
           if let userInfo = notification.userInfo, let yemek = userInfo["yemek"] as? Yemekler {
               
               // ✅ Sepete ekleme işlemi
               detayViewModel.sepeteEkle(yemek_adi: yemek.yemek_adi!,
                                    yemek_resim_adi: yemek.yemek_resim_adi!,
                                    yemek_fiyat: yemek.yemek_fiyat!,
                                    yemek_siparis_adet: "1",
                                    kullanici_adi: "reyhan")

               print("📌 \(yemek.yemek_adi!) sepete eklendi ve sepet güncellendi.")

               // ✅ Yeni yemek sepete eklendikten sonra TableView'ı güncelle
               viewModel.yemekleriYukle()
               viewModel.sepetiGetir(kullanici_adi: "reyhan")

               DispatchQueue.main.async {
                   self.yemeklerTableView.reloadData()
                   self.hesaplaToplamTutar()
               }
           }
       }*/

    
    func hesaplaToplamTutar() {
        var toplamTutar = 0
        
        for sepetElemani in yemekListesi {
            if let adetInt = Int(sepetElemani.yemek_siparis_adet ?? "1"),
               let fiyatInt = Int(sepetElemani.yemek_fiyat ?? "0") {
                toplamTutar += adetInt * fiyatInt
            }
        }
        
        labelSepetToplamDeger.text = "\(toplamTutar) ₺"
    }
    
  /*  deinit {
           NotificationCenter.default.removeObserver(self, name: NSNotification.Name("SepeteYemekEkle"), object: nil)
       }*/
    
    func showConfirmationAlert() {
            let confirmationAlert = UIAlertController(title: "Başarılı",
                                                      message: "Siparişinizi en kısa sürede teslim edeceğiz!",
                                                      preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
            
            confirmationAlert.addAction(okAction)
            
            self.present(confirmationAlert, animated: true, completion: nil)
        }
    
    func gruplanmisYemekListesiOlustur() -> [SepetYemekler] {
        var yemekDict = [String: SepetYemekler]() // Aynı yemekleri saklamak için sözlük

        for yemek in yemekListesi {
            if let mevcutYemek = yemekDict[yemek.yemek_adi!] {
                // Eğer yemek zaten eklenmişse, adet değerini topla
                let yeniAdet = (Int(mevcutYemek.yemek_siparis_adet ?? "1") ?? 1) + (Int(yemek.yemek_siparis_adet ?? "1") ?? 1)
                mevcutYemek.yemek_siparis_adet = "\(yeniAdet)"
            } else {
                // Eğer yemek listede yoksa, yeni olarak ekle
                yemekDict[yemek.yemek_adi!] = yemek
            }
        }

        return Array(yemekDict.values)
    }

    
    
    
    @IBAction func buttonSepetiOnayla(_ sender: Any) {
        
        let alert = UIAlertController(title: "Sipariş Onayı",
                                             message: "Siparişinizi onaylamak istediğinize emin misiniz?",
                                      preferredStyle: .actionSheet)
               
        let confirmAction = UIAlertAction(title: "Evet", style: .destructive) { _ in
                   print("Sipariş onaylandı!")
            
            self.showConfirmationAlert()
                   // Siparişi onaylama işlemi burada yapılabilir
               }
               
               let cancelAction = UIAlertAction(title: "İptal", style: .cancel, handler: nil)

               alert.addAction(confirmAction)
               alert.addAction(cancelAction)

               self.present(alert, animated: true, completion: nil)
           }
}
        
    
    
    



extension SepetSayfa : UITableViewDelegate,UITableViewDataSource {
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yemekListesi.count
    }
    
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let hucre = tableView.dequeueReusableCell(withIdentifier: "sepetYemekHucre", for: indexPath) as! TableViewCell
            
            let sepetElemani = yemekListesi[indexPath.row]
            
            // Burada hücrede göstereceğiniz her bir label’ı doldurursunuz
            hucre.labelAdetDeger.text = "\(Int(sepetElemani.yemek_siparis_adet ?? "1") ?? 1)"
            hucre.labelFiyatDeger.text = "\(Int(sepetElemani.yemek_fiyat ?? "0") ?? 0) ₺"
            
            if let adetInt = Int(sepetElemani.yemek_siparis_adet ?? "1"),
               let fiyatInt = Int(sepetElemani.yemek_fiyat ?? "0") {
                let toplam = adetInt * fiyatInt
                hucre.labelToplamFiyatDeger.text = "\(toplam) ₺"
            
               
            }

            
            // Resim ayarı (Kingfisher örneği)
            if let resimAdi = sepetElemani.yemek_resim_adi {
                let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(resimAdi)")
                hucre.sepetImageView.kf.setImage(with: url)
                
                print("geçtiHÜCRE")

            }
            
            return hucre
        }
          
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        
        let silAction = UIContextualAction(style: .destructive, title: "Sil"){contextualAction,view,bool in
            let yemek = self.yemekListesi[indexPath.row]
            
            let alert = UIAlertController(title: "Silme İşlemi", message: "\(yemek.yemek_adi!) silinsin mi?", preferredStyle: .alert)
            
            let iptalAction = UIAlertAction(title: "İptal", style: .cancel)
            alert.addAction(iptalAction)
            
            let evetAction = UIAlertAction(title: "Evet", style: .destructive){ action in
                self.viewModel.sepettenYemekSil(kullanici_adi: yemek.kullanici_adi, sepet_yemek_id: yemek.sepet_yemek_id!)
                
                // 1) O satırdaki "adet" bilgisini integer olarak al
                       let adetInt = Int(yemek.yemek_siparis_adet ?? "1") ?? 1

                       // 2) Adet kadar sunucuya silme isteği gönder
                       for _ in 1...adetInt {
                           self.viewModel.sepettenYemekSil(
                               kullanici_adi: yemek.kullanici_adi,
                               sepet_yemek_id: yemek.sepet_yemek_id!
                           )
                       }
                
                self.yemekListesi.remove(at: indexPath.row)
                //DispatchQueue.main.async {
                               self.yemeklerTableView.deleteRows(at: [indexPath], with: .automatic)
                               self.hesaplaToplamTutar() // Yeni toplamı güncelle
                        //   }
              //  self.viewModel.yemekleriYukle()
            }
            alert.addAction(evetAction)
            
            self.present(alert, animated: true)
        }
       // viewModel.yemekleriYukle()
        return UISwipeActionsConfiguration(actions: [silAction])
    }
    }

