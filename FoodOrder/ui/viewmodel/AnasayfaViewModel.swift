//
//  AnasayfaViewModel.swift
//  FoodOrder
//
//  Created by Reyhan Nur Ünlü on 8.12.2024.
//

import Foundation
import RxSwift

class AnasayfaViewModel {
    var frepo = YemeklerDaoRepository()
    var yemeklerListesi = BehaviorSubject<[Yemekler]>(value: [Yemekler]())
    
    init(){
        yemeklerListesi = frepo.yemeklerListesi
        yemekleriYukle()
    }
    
    func yemekleriYukle(){
        frepo.yemekleriYukle()
        
        _ = yemeklerListesi.subscribe(onNext: { liste in
                print("Yemekler Listesi (ViewModel): \(liste)") // Burada listeyi yazdırabilirsiniz
            })
        }
    }
    
    


