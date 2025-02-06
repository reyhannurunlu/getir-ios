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
        sepetiGetir(kullanici_adi: kullanici_adi?.kullanici_adi ?? "kullanıcı adı bulunamadı")
    }
    
    func yemekleriYukle(){
        repo.yemekleriYukle()
    }
    
    func sepetiGetir(kullanici_adi: String){
        repo.sepetiGetir(kullanici_adi: kullanici_adi)
    }
    
}
