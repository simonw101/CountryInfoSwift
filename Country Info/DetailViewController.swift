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

        if let country = selectedCountry {
            
            print(country.countryName)
            print(country.areaOfCountry)
            print(country.region)
            print(country.flagUrl)
            print(country.lat)
            print(country.long)
            print(country.languages)
            print(country.currencyCode)
            print(country.currencySymbol)
            print(country.currencyName)
            print(country.nativeName)
            
        }
        
       
        
    }
    

}
