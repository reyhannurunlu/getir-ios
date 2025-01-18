//
//  SepetSayfaViewController.swift
//  FoodOrder
//
//  Created by Reyhan Nur Ünlü on 22.12.2024.
//

import UIKit

class SepetSayfa: UIViewController {
    
    @IBOutlet weak var labelSepetToplamDeger: UILabel!
    
    @IBOutlet weak var labelSepetToplam: UILabel!
    
    @IBOutlet weak var yemeklerTableView: UITableView!
    
    var cartContent : Yemekler?
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
   
    @IBAction func buttonSepetiOnayla(_ sender: Any) {
        //alert
        print(cartContent?.yemek_fiyat ?? 0)
        
    }
    

}
