//
//  DetaySayfaViewModel.swift
//  FoodOrder
//
//  Created by Reyhan Nur Ünlü on 20.12.2024.
//

import Foundation

class DetaySayfaViewModel {
    var krepo = YemeklerDaoRepository()
    
    func sepeteEkle (yemek_adi:String , yemek_resim_adi:String , yemek_fiyat:String , yemek_siparis_adet:String , kullanici_adi:String ) {
        krepo.kaydet(yemek_adi: yemek_adi, yemek_resim_adi: yemek_resim_adi, yemek_fiyat: yemek_fiyat, yemek_siparis_adet: yemek_siparis_adet, kullanici_adi: kullanici_adi)
    }
}
