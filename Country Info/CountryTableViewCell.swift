//
//  CountryTableViewCell.swift
//  Country Info
//
//  Created by Simon Wilson on 01/03/2021.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var countryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
