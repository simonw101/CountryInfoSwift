//
//  ViewController.swift
//  Country Info
//
//  Created by Simon Wilson on 27/02/2021.
//

import UIKit

var flagArray = [String]()
var countryNameArray = [String]()

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        
        tableView.dataSource = self
        
        downloadAndParse()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        flagArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = countryNameArray[indexPath.row]
        return cell
    }
    
    func downloadAndParse() {
        
        if let url = URL(string: "https://restcountries.eu/rest/v2/all") {
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    
                    print(error?.localizedDescription)
                    
                } else {
                    
                    if let jsonData = data {
                        
                        do {
                            
                            let jsonResponse = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
                            
                            //print(jsonResponse)
                            
                            if let parseData = jsonResponse as? [Any?] {
                                
                                for item in parseData {
                                    
                                    if let country = item as? [String : Any] {
                                        
                                        DispatchQueue.main.async {
                                           
                                            if let flagURL = country["flag"] as? String {
                                                
                                                flagArray.append(flagURL)
                                                
                                            }
                                            
                                            if let countryName = country["name"] as? String {
                                                
                                                countryNameArray.append(countryName)
                                                
                                            }
                                            
                                            self.tableView.reloadData()
                                            
                                        }
                                        
                                    }
                                    
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
    
    
}
