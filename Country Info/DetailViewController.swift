//
//  DetailViewController.swift
//  Country Info
//
//  Created by Simon Wilson on 27/02/2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    var selectedCountry: CountryObject? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        print(selectedCountry?.countryName)
        
    }
    

}
