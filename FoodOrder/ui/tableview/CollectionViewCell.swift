//
//  CollectionViewCell.swift
//  FoodOrder
//
//  Created by Reyhan Nur Ünlü on 8.12.2024.
//

import UIKit

protocol HucreProtocol {
    func sepeteEkleTikla(indexPath:IndexPath)
}

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var buttonSepeteEkle: UIButton!
    
    @IBOutlet weak var imageViewYemek: UIImageView!
    
    @IBOutlet weak var labelFiyat: UILabel!
    
    var hucreProtocol:HucreProtocol?
    var indexPath:IndexPath?
    
  /*  override func awakeFromNib() {
          super.awakeFromNib()
          
          // ✅ Renk değişimi burada yapılmalı!
          buttonSepeteEkle.tintColor = UIColor.systemOrange
      }*/
   
    
    @IBAction func buttonSepeteEkle(_ sender: Any) {
        hucreProtocol?.sepeteEkleTikla(indexPath: indexPath!)
    }
    
    
}
