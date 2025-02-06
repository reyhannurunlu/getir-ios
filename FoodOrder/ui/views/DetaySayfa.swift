//
//  DetaySayfa.swift
//  FoodOrder
//
//  Created by Reyhan Nur Ünlü on 10.12.2024.
//

import UIKit
import Kingfisher
import Alamofire


class DetaySayfa : UIViewController {
    
    @IBOutlet weak var imageViewYemek: UIImageView!
    
    @IBOutlet weak var labelYemekAd: UILabel!
    
    @IBOutlet weak var labelYemekFiyat: UILabel!
    
    @IBOutlet weak var labelYemekAdet: UILabel!
    
    @IBOutlet weak var labelDetay1: UILabel!
    
    @IBOutlet weak var labelDetay2: UILabel!
    
    @IBOutlet weak var labelDetay3: UILabel!
    
    @IBOutlet weak var labelTotalFiyat: UILabel!
    
    var yemek : Yemekler?
    var yemekAdedi  = 1
    var viewModel = DetaySayfaViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
        
        if let yemek = yemek{
            labelYemekAd.text = yemek.yemek_adi
            labelYemekFiyat.text = " ₺ \(yemek.yemek_fiyat ?? "yemek bulunamadı") "
            
        
            
            // if(yemek.yemek_resim_adi == nil) {
            // yemek.yemek_resim_adi = "0"
            let resimAdi = yemek.yemek_resim_adi ?? "default.png"
            
            if let URL = URL (string: "http://kasimadalan.pe.hu/yemekler/resimler/\(resimAdi)"){ //resim nesnesini istedik
                DispatchQueue.main.async {
                    self.imageViewYemek.kf.setImage(with: URL) { result in
                        switch result {
                        case .success(let value):
                            print("Görsel başarıyla yüklendi: \(value.source.url?.absoluteString ?? "")")
                        case .failure(let error):
                            print("Görsel yükleme hatası: \(error.localizedDescription)")
                        }
                        
                    }
                }
            }
            
        }
        
    }
   /*func updatelabelYemekAdet() {
        labelYemekAdet.text = "\(yemekAdedi)"
    }*/
    
    @IBAction func buttonAdetAzalt(_ sender: Any) {
        if yemekAdedi > 1 {
            yemekAdedi -= 1
            updateUI()        }
    }
    
    @IBAction func buttonAdetArttır(_ sender: Any) {
        yemekAdedi += 1
        updateUI()
    }
    func updateUI() {
        // Adet etiketini güncelle
        labelYemekAdet.text = "\(yemekAdedi)"
        
        
        if let safeContent = yemek {
            if let labelYemekFiyat = Int(safeContent.yemek_fiyat!),
               let adetText = labelYemekAdet.text,
               let adet = Int(adetText) {

                
                let priceValue = adet * labelYemekFiyat
                labelTotalFiyat.text = "\(priceValue)₺"
            }
        }
    }
    
    @IBAction func buttonSepeteEkle(_ sender: Any) {
        updateUI()
        
        if let safeContent = yemek {
            if let covertedPrice = Int(safeContent.yemek_fiyat!) {
                viewModel.sepeteEkle(yemek_adi: safeContent.yemek_adi! , yemek_resim_adi: safeContent.yemek_resim_adi! , yemek_fiyat: String(covertedPrice), yemek_siparis_adet: String(yemekAdedi), kullanici_adi: "reyhan")
                print("\(yemek?.yemek_adi ?? "Bilinmeyen yemek") sepete eklendi")
            } else {
                print("Convert Error !")
            }
        }
        performSegue(withIdentifier: "detailToCart", sender: yemek)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailToCart" {
            if let safeSender = sender as? Yemekler {
                let destinationVC = segue.destination as! SepetSayfa
                destinationVC.cartContent = safeSender
            }
        }
    }
}


