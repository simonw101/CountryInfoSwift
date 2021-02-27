//
//  ViewController.swift
//  Country Info
//
//  Created by Simon Wilson on 27/02/2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var countryNameArray = [String]()
    var phoneCodes = [String]()
    var domainArray = [String]()
    var capitalArray = [String]()
    var populationArray = [String]()
    var demonymArray = [String]()
    var flagArray = [String]()
    var languageArray = [String]()
    var currencyArray = [String]()
    
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
                            
                            //print(jsonResponse)
                            
                            if let parseData = jsonResponse as? [Any] {
                                
                                DispatchQueue.main.async {
                                    
                                    repeat {
                                        
                                        if let country = parseData[counter] as? [String: Any] {
                                            
                                            if let countryName = country["name"] as? String {
                                                
                                                self.countryNameArray.append(countryName)
                                                
                                            }
                                            
                                            if let phoneCode = country["callingCodes"] as? [String] {
                                                
                                                self.phoneCodes.append(phoneCode[0])
                                                
                                            }
                                            
                                            if let domainCode = country["topLevelDomain"] as? [String] {
                                                
                                                self.domainArray.append(domainCode[0])
                                                
                                            }
                                            
                                            if let capital = country["capital"] as? String {
                                                
                                                if capital == "" {
                                                    
                                                    self.capitalArray.append("N/A")
                                                    
                                                } else {
                                                
                                                self.capitalArray.append(capital)
                                                    
                                                }
                                                
                                            }
                                            
                                            if let population = country["population"] as? Double {
                                                
                                                let numberFormatter = NumberFormatter()
                                                numberFormatter.numberStyle = .decimal
                                                let formattedNumber = numberFormatter.string(from: NSNumber(value:population))
                                                    
                                                if let number = formattedNumber {
                                                    
                                                self.populationArray.append(number)
                                                    
                                                }
                                          
                                                
                                            }
                                            
                                            if let demonym = country["demonym"] as? String {
                                                
                                                if demonym == "" {
                                                    
                                                    self.demonymArray.append("N/A")
                                                    
                                                } else {
                                                
                                                self.demonymArray.append(demonym)
                                                    
                                                }
                                                
                                            }
                                            
                                            if let flagUrl = country["flag"] as? String {
                                                
                                                self.flagArray.append(flagUrl)
                                                
                                            }
                                            
//                                            if let currency = country["currencies"] as? [Any] {
//
//                                                for i in 0...(currency.count - 1) {
//
//                                                   print(currency[i])
//
//                                                }
//
//                                            }
                                            
                                            
                                        }
                                        
                                        counter += 1
                                        
                                    } while counter <= (parseData.count - 1)
                                    
                                    self.tableView.reloadData()
                                    
                                }
                                
                            }
                            
                        } catch {
                            
                            print("unable to access json")
                            
                        }
                        
                        
                    }
                    
                    
                }
                
                
                
            }
            
            task.resume()
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countryNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(demonymArray[indexPath.row])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "toDetailVC", sender: nil)
        
    }
    
}

