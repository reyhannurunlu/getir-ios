//
//  SepetSayfa.swift
//  FoodOrder
//
//  Created by Reyhan Nur Ünlü on 22.12.2024.
//

import Foundation
import Alamofire
import RxSwift

class SepetSayfaViewModel {
    var repo = YemeklerDaoRepository()
    var kullanici_adi : SepetYemekler?
    //var yemeklistesi = AnasayfaViewModel()
    var sepetYemeklerListesi = BehaviorSubject<[SepetYemekler]>(value: [SepetYemekler]())
    
    init(){
        sepetYemeklerListesi = repo.sepetYemeklerListesi //unwrap
        yemekleriYukle()
        sepetiGetir(kullanici_adi: kullanici_adi?.kullanici_adi ?? "reyhan")
    }
    
    func yemekleriYukle(){
        repo.yemekleriYukle()
    }
    
    func sepetiGetir(kullanici_adi: String){
        repo.sepetiGetir(kullanici_adi: kullanici_adi)
    }
    
    func sepettenYemekSil(kullanici_adi: String , sepet_yemek_id : String ){
        repo.sepettenYemekSilme(sepet_yemek_id: sepet_yemek_id, kullanici_adi: kullanici_adi)
       // yemekleriYukle()
    }
   /* func tumSepetiSil(kullanici_adi: String) {
        // Eğer sepet zaten boşsa işlem yapma
        guard let liste = try? sepetYemeklerListesi.value(), !liste.isEmpty else { return }

        // Tüm ürünleri sırayla API'ye göndererek sil
        for yemek in liste {
            repo.sepettenYemekSilme(sepet_yemek_id: yemek.sepet_yemek_id!, kullanici_adi: kullanici_adi)
        }

        // UI'yi güncellemek için boş liste gönder
        sepetYemeklerListesi.onNext([])
    }*/

}
