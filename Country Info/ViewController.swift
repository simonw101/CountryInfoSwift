//
//  ViewController.swift
//  Country Info
//
//  Created by Simon Wilson on 27/02/2021.
//

import UIKit
import SDWebImage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var countryArray = [CountryObject]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        
        tableView.dataSource = self
        
        downloadAndParse()
        
    }
    
    func downloadAndParse() {
        
        if let url = URL(string: "http://countryapi.gear.host/v1/Country/getCountries") {
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if let error = error {
                    
                    print(error.localizedDescription)
                    
                } else {
                    
                    if let jsonData = data {
                        
                        do {
                            
                            let jsonResponse = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
                            
                            //                            print(jsonResponse)
                            
                            if let parseData = jsonResponse as? [String : Any] {
                                
                                DispatchQueue.main.async {
                                    
                                    
                                    
                                    if let countryData = parseData["Response"] as? [Any] {
                                        
                                        for country in countryData {
                                            
                                            var countryObject = CountryObject()
                                            
                                            if let countryItem = country as? [String : Any] {
                                                
                                                if let countryName = countryItem["Name"] as? String {
                                                    
                                                    countryObject.countryName = countryName
                                                    
                                                    if let nativeName = countryItem["NativeName"] as? String {
                                                        
                                                        countryObject.nativeName = nativeName
                                                        
                                                        if let region = countryItem["SubRegion"] as? String {
                                                            
                                                            countryObject.region = region
                                                            
                                                            if let flagurl = countryItem["FlagPng"] as? String {

                                                                countryObject.flagUrl = flagurl
                                                                
                                                                if let area = countryItem["Area"] as? Int {
                                                                    
                                                                    countryObject.areaOfCountry = area
                                                                    
                                                                    if let latitude = countryItem["Latitude"] as? String {

                                                                        countryObject.lat = latitude
                                                                        
                                                                        if let longitude = countryItem["Longitude"] as? String {
                                                                            
                                                                            countryObject.lat = longitude
                                                                            
                                                                            if let currencyCode = countryItem["CurrencyCode"] as? String {
                                                                                
                                                                                countryObject.currencyCode = currencyCode
                                                                                
                                                                                if let currencyName = countryItem["CurrencyName"] as? String {
                                                                                    
                                                                                    countryObject.currencyName = currencyName
                                                                                    
                                                                                    if let currencySymbol = countryItem["CurrencySymbol"] as? String {
                                                                                        
                                                                                        countryObject.currencySymbol = currencySymbol
                                                                                        
                                                                                        if let language = countryItem["NativeLanguage"] as? String {
                                                                                            
                                                                                            countryObject.languages = language
                                                                                            
                                                                                        }
                                                                                        
                                                                                    }
                                                                                    
                                                                                }
                                                                            }
                                                                            
                                                                        }
                                                                        
                                                                    }
                                                                    
                                                                    
                                                                    
                                                                }
                                                                
                                                            }
                                                            
                                                        }
                                                        
                                                    }
                                                    
                                                    self.countryArray.append(countryObject)
                                                }
                                                
                                            }
                                            
                                        }
                                        
                                        
                                    }
                                    
                                    
                                    
                                    self.tableView.reloadData()
                                    
                                }
                                
                                
                                
                            }
                            
                        } catch {
                            
                            
                            
                        }
                        
                    }
                    
                    
                }
                
                
                
            }
            
            task.resume()
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CountryTableViewCell
        
        cell.countryName.text = countryArray[indexPath.row].countryName
        cell.nativeName.text = "Native Name: \(countryArray[indexPath.row].nativeName)"
        cell.regionLabel.text = "Region: \(countryArray[indexPath.row].region)"
        
        if let url = URL(string: countryArray[indexPath.row].flagUrl) {
            
            cell.imageCell.sd_setImage(with: url, completed: nil)
            
            
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let chosenCountry = countryArray[indexPath.row]
        
        performSegue(withIdentifier: "toDetailVC", sender: chosenCountry)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            
            if let detailsVC = segue.destination as? DetailViewController {
                
                detailsVC.selectedCountry = sender as? CountryObject
                
            }
            
        }
    }
    
}

