//
//  TableViewCell.swift
//  FoodOrder
//
//  Created by Reyhan Nur Ünlü on 22.12.2024.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var sepetImageView: UIImageView!
    
    @IBOutlet weak var labelFiyat: UILabel!
    
    @IBOutlet weak var labelAdet: UILabel!
    
    @IBOutlet weak var labelFiyatDeger: UILabel!
    
    @IBOutlet weak var labelAdetDeger: UILabel!
    
    @IBOutlet weak var labelToplamFiyatDeger: UILabel!
    
    let yemekAdedi = DetaySayfa()
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
