//
//  ViewController.swift
//  FoodOrder
//
//  Created by Reyhan Nur Ünlü on 7.12.2024.
//

import UIKit
import Alamofire
import Kingfisher

class Anasayfa: UIViewController  {
   // var isPerformingSegue = false

    @IBOutlet weak var sepetim: UITabBarItem!
    //buna basarak bir yere gitmez mi
    @IBOutlet weak var YemeklerCollectionView: UICollectionView!
    
    var yemeklerListesi = [Yemekler]()
    var viewModel = AnasayfaViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        YemeklerCollectionView.delegate = self
        YemeklerCollectionView.dataSource = self
        
        _ = viewModel.yemeklerListesi.subscribe(onNext: { liste in
            self.yemeklerListesi = liste
            self.YemeklerCollectionView.reloadData()
        })
        
        print("yemeklerListesi = \(yemeklerListesi)")
        
        let tasarim = UICollectionViewFlowLayout()
        tasarim.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tasarim.minimumInteritemSpacing = 10
        tasarim.minimumLineSpacing = 10
        
        //10 X 10 X 10 = 30
        //15 X 10 X 10 X 15 = 50
        let ekranGenislik = UIScreen.main.bounds.width
        let itemGenislik = (ekranGenislik - 30) / 2
        
        tasarim.itemSize = CGSize(width: itemGenislik, height: itemGenislik*1.6)
        
        YemeklerCollectionView.collectionViewLayout = tasarim
    }
}
extension Anasayfa : UICollectionViewDelegate,UICollectionViewDataSource,HucreProtocol {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("yemeklerListesi.count = \(yemeklerListesi.count)")
        return yemeklerListesi.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let yemek = yemeklerListesi[indexPath.row]
        print(yemeklerListesi)
        
        let hucre = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        
        //hucre.imageViewFilm.image = UIImage(named: film.resim!)
        if(yemek.yemek_resim_adi == nil) {
            yemek.yemek_resim_adi = "0"
        }
        
        if let URL = URL (string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemek.yemek_resim_adi!)"){
            DispatchQueue.main.async {
                hucre.imageViewYemek.kf.setImage(with: URL)
                print(yemek.yemek_resim_adi!)
            }
        }
        
        if(yemek.yemek_fiyat == nil) {
            yemek.yemek_fiyat =  "0"
        }
        hucre.labelFiyat.text = "₺ \(yemek.yemek_fiyat!) "
        
        hucre.layer.borderColor = UIColor.lightGray.cgColor
        hucre.layer.borderWidth = 0.3
        hucre.layer.cornerRadius = 10.0
        
        hucre.hucreProtocol = self
        hucre.indexPath = indexPath
        
        return hucre
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       // guard !isPerformingSegue else { return } // Eğer bir segue zaten çalışıyorsa, yeni bir tane başlatma
        
       // isPerformingSegue = true // Segue başlatıldığında true yap
        let secilenYemek = yemeklerListesi[indexPath.row]
        print("Seçilen Yemek: \(secilenYemek.yemek_adi ?? "Bilinmiyor")")
        performSegue(withIdentifier: "toDetay", sender: secilenYemek)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "toDetay" {
                if let detayVC = segue.destination as? DetaySayfa ,
                    let yemek = sender as? Yemekler {
                                    detayVC.yemek = yemek
                                }
                
               /* let destinationVC = segue.destination as! DetaySayfa
                if let cell = sender as? UICollectionViewCell,
                   let indexPath = YemeklerCollectionView.indexPath(for: cell) // cell den bağlamışım storyboard da seguede görünüyor
            {
                    let secilenYemek = yemeklerListesi[indexPath.row]
                    destinationVC.yemek = secilenYemek
                } else {
                    print("Seçilen yemek bulunamadı")*/
                }
            }
        
   
        
      //  DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        //    self.isPerformingSegue = false // Segue işlemi tamamlandıktan sonra flag'i sıfırla
       // }
    //}
        
    
        
        func sepeteEkleTikla(indexPath: IndexPath) {
            let yemek = yemeklerListesi[indexPath.row]
            print("\(yemek.yemek_adi!) sepete eklendi")
            
            viewModel.frepo.kaydet(yemek_adi: yemek.yemek_adi!, yemek_resim_adi: yemek.yemek_resim_adi!, yemek_fiyat: yemek.yemek_fiyat!, yemek_siparis_adet: "1", kullanici_adi: "reyhan")
            
          /*  NotificationCenter.default.post(name: NSNotification.Name("SepeteYemekEkle"), object: nil, userInfo: ["yemek": yemek]) 

               print("\(yemek.yemek_adi!) noti noti sepete eklendi!")*/
           }
        }
   // }




