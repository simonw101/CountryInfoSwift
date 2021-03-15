//
//  CountryTableViewCell.swift
//  Country Info
//
//  Created by Simon Wilson on 01/03/2021.
//

import UIKit


class CountryTableViewCell: UITableViewCell {

    
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var nativeName: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
