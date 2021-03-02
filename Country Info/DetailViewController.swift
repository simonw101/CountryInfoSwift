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
            print(country.phoneCode)
            print(country.domainName)
            print(country.capital)
            print(country.population)
            print(country.demonym)
            print(country.flagUrl)
            print(country.languages)
            print(country.currency)
            
        }
        
       
        
    }
    

}
