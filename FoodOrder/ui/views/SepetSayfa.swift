//
//  SepetSayfaViewController.swift
//  FoodOrder
//
//  Created by Reyhan Nur Ünlü on 22.12.2024.
//

import UIKit
import Kingfisher

class SepetSayfa: UIViewController {
    
    @IBOutlet weak var labelSepetToplamDeger: UILabel!
    
    @IBOutlet weak var labelSepetToplam: UILabel!
    
    @IBOutlet weak var yemeklerTableView: UITableView!
    
    var viewModel : SepetSayfaViewModel?
    var cartContent : Yemekler?
    var yemekListesi = [SepetYemekler]()
    var adet : DetaySayfa?
    var sepetYemek : SepetYemekler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("geçtiDIDLOAD")

   
        yemeklerTableView.delegate = self
        yemeklerTableView.dataSource = self
        
        _ = viewModel?.sepetYemeklerListesi.subscribe(onNext: { liste in
            self.yemekListesi = liste
            print("geçti")
            
            DispatchQueue.main.async{ // daha performanslı asenkron çalışmalar için
                self.yemeklerTableView.reloadData()
                print("geçti22")

            }
        })
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        viewModel?.yemekleriYukle()
        
        super.viewWillAppear(animated)
        
        viewModel?.sepetiGetir(kullanici_adi: sepetYemek?.kullanici_adi ?? "kullanıcı bulunamadı")
        
        self.yemeklerTableView.reloadData()
        print("geçti33")

    }
   
    @IBAction func buttonSepetiOnayla(_ sender: Any) {
        //alert
        print(cartContent?.yemek_fiyat ?? 0)
        
    }
    

}


extension SepetSayfa : UITableViewDelegate,UITableViewDataSource {
    
    //viewModel?.sepetiGetir(kullanici_adi: <#T##String#>)
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yemekListesi.count
    }
    
        
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let hucre = tableView.dequeueReusableCell(withIdentifier: "sepetYemekHucre", for: indexPath) as! TableViewCell
            
            let sepetElemani = yemekListesi[indexPath.row]
            
            // Burada hücrede göstereceğiniz her bir label’ı doldurursunuz
            hucre.labelAdetDeger.text = "\(sepetElemani.yemek_siparis_adet ?? 1)"
            hucre.labelFiyatDeger.text = "\(sepetElemani.yemek_fiyat ?? 0) ₺"

            if let adet = sepetElemani.yemek_siparis_adet,
               let fiyat = sepetElemani.yemek_fiyat {
                let toplam = adet * fiyat
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
        
        // (Opsiyonel) Silme/sürükleme vb. fonksiyonlar
        // func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool { ... }
        // func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) { ... }
    }

