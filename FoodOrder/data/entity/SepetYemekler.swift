//
//  SepetYemekler.swift
//  FoodOrder
//
//  Created by Reyhan Nur Ünlü on 12.12.2024.
//

import Foundation
import Alamofire

class SepetYemekler: Codable {
    var sepet_yemek_id : Int?
    var yemek_adi:String?
    var yemek_resim_adi:String?
    var yemek_fiyat:Int?
    var yemek_siparis_adet : Int?
    var kullanici_adi : String?
    
    
    init() {
        
    }
    
    init(sepet_yemek_id: Int, yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int , yemek_siparis_adet: Int , kullanici_adi: String) {
        self.sepet_yemek_id = sepet_yemek_id
        self.yemek_adi = yemek_adi
        self.yemek_resim_adi = yemek_resim_adi
        self.yemek_fiyat = yemek_fiyat
        self.yemek_siparis_adet = yemek_siparis_adet
        self.kullanici_adi = kullanici_adi
    }
}


