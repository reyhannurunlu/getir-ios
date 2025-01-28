//
//  FilmlerDaoRepository.swift
//  FoodOrder
//
//  Created by Reyhan Nur Ünlü on 9.12.2024.
//

import Foundation
import RxSwift
import Alamofire


class YemeklerDaoRepository {
    var yemeklerListesi = BehaviorSubject<[Yemekler]>(value: [Yemekler]())
    
    var sepetYemeklerListesi = BehaviorSubject<[SepetYemekler]>(value: [SepetYemekler]())
    
    func yemekleriYukle(){
        // filmlerListesi.onNext(liste)
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php" , method: .get) .response { response in
            
            if let data = response.data {
                do{
                    let cevap = try JSONDecoder().decode(YemeklerCevap.self , from: data)
                    if let liste = cevap.yemekler{
                        self.yemeklerListesi.onNext(liste)
                        print("DOĞRU ÇALIŞTI")
                    }
                    
                }catch{
                    print(error.localizedDescription)
                    print("YANLIŞ ÇALIŞTI")
                    
                }
            }
        }
    }
    
    func kaydet (yemek_adi:String , yemek_resim_adi:String , yemek_fiyat:String , yemek_siparis_adet:String , kullanici_adi:String ) {
        
        let params : Parameters = [ "yemek_adi":yemek_adi , "yemek_resim_adi":yemek_resim_adi , "yemek_fiyat":yemek_fiyat , "yemek_siparis_adet":yemek_siparis_adet , "kullanici_adi":kullanici_adi ]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php",method: .post ,parameters: params) .response { response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(CRUDSCevap.self, from: data)
                    print("başarı : \(cevap.success!)")
                    print("mesaj : \(cevap.message!)")
                    // self.yemekleriYukle(kullanici_adi : kullanici_adi)
                    
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func sepetiGetir(kullanici_adi: String) {
        let params: Parameters = ["kullanici_adi": kullanici_adi]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php",method: .post,
                   parameters: params) .response {response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode( SepetYemeklerCevap.self, from: data)
                    if let liste = cevap.sepetYemekler {
                        self.sepetYemeklerListesi.onNext(liste)
                        print("Sepete çekildi")
                       }
                    } catch {
                        print("Sepet çekme hatası: \(error)")
                    }
                }
            }
            
        }
    }

