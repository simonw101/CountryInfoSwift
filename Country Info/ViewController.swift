//
//  ViewController.swift
//  Country Info
//
//  Created by Simon Wilson on 27/02/2021.
//

import UIKit
import SDWebImageSVGCoder

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
        
        var counter = 0
        
        if let url = URL(string: "https://restcountries.eu/rest/v2/all") {
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if let error = error {
                    
                    print(error.localizedDescription)
                    
                } else {
                    
                    if let jsonData = data {
                        
                        do {
                            
                            let jsonResponse = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
                            
                            if let parseData = jsonResponse as? [Any] {
                                
                                DispatchQueue.main.async {
                                    
                                    repeat {
                                        
                                        let countryObj = CountryObject()
                                        
                                        if let country = parseData[counter] as? [String: Any] {
                                            
                                            if let countryName = country["name"] as? String {
                                                
                                                if let domain = country["topLevelDomain"] as? [Any] {
                                                    
                                                    if let domainCode = domain[0] as? String {
                                                        
                                                        if let phoneCode = country["callingCodes"] as? [Any] {
                                                            
                                                            if let code = phoneCode[0] as? String {
                                                                
                                                                if let capitalCity = country["capital"] as? String {
                                                                    
                                                                    if let population = country["population"] as? Int {
                                                                        
                                                                        if capitalCity == "" {
                                                                            
                                                                            countryObj.capital = "N/A"
                                                                            
                                                                        } else {
                                                                            
                                                                            countryObj.capital = capitalCity
                                                                            
                                                                        }
                                                          
                                                                        if code == "" {
                                                                            
                                                                            countryObj.phoneCode = "N/A"
                                                                            
                                                                        } else {
                                                                            
                                                                            countryObj.phoneCode = code
                                                                            
                                                                        }
                                                                        
                                                                        countryObj.domainName = domainCode
                                                                        countryObj.countryName = countryName
                                                                        
                                                                        let largeNumber = population
                                                                        let numberFormatter = NumberFormatter()
                                                                        numberFormatter.numberStyle = .decimal
                                                                        let formattedNumber = numberFormatter.string(from: NSNumber(value:largeNumber))
                                                                        
                                                                        if let convertedPop = formattedNumber {
                                                                            
                                                                            countryObj.population = convertedPop
                                                                            
                                                                        }
                                                                        
                                                                        if let flagURL = country["flag"] as? String {
                                                                            
                                                                            if flagURL == "" {
                                                                                
                                                                                countryObj.flagUrl = ""
                                                                                
                                                                            } else {
                                                                                
                                                                                countryObj.flagUrl = flagURL
                                                                                
                                                                                
                                                                            }
                                                                            
                                                                            
                                                                            
                                                                        }
                                                                        
                                                                        if let demonym = country["demonym"] as? String {
                                                                            
                                                                            if demonym == "" {
                                                                                
                                                                                countryObj.demonym = "N/A"
                                                                            } else {
                                                                                
                                                                                countryObj.demonym = demonym
                                                                            }
                                                    
                                                                            
                                                                        }
                                                                        
                                                                        if let currencyArray = country["currencies"] as? [Any] {
                                                                            
                                                                            countryObj.currency = currencyArray
                                                                                
                                                                            
                                                                        }
                                                                        
                                                                        if let languageArray = country["languages"] as? [Any] {
                                                                            
                                                                            countryObj.languages = languageArray
                                                                            
                                                                        }

                                                                        
                                                                    }
                                                                    
                                                                }
                                                                
                                                                
                                                            }
                                                            
                                                        }
                                                        
                                                    }
                                                    
                                                    
                                                }
                                                
                                            }
                                            
                                            
                                        }
                                        
                                        counter += 1
                                        
                                        self.countryArray.append(countryObj)
                                        
                                    } while counter <= parseData.count - 1
                                    
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
        
        let SVGCoder = SDImageSVGCoder.shared
        SDImageCodersManager.shared.addCoder(SVGCoder)
        
        if let url = URL(string: countryArray[indexPath.row].flagUrl) {
        
            cell.flagImage.sd_setImage(with: url, completed: nil)
            
        } else {
            
            cell.flagImage.image = UIImage(named: "placeholderimage")
            
        }
       
        
        cell.countryName.text = countryArray[indexPath.row].countryName
        cell.capitalLabel.text = "Capital: \(countryArray[indexPath.row].capital)"
        cell.populationLabel.text = "Population: \(countryArray[indexPath.row].population)"
        
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

