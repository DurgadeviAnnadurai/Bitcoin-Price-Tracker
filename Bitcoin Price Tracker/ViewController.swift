//
//  ViewController.swift
//  Bitcoin Price Tracker
//
//  Created by Durgadevi Annadurai on 13/10/2019.
//  Copyright © 2019 Durgadevi Annadurai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lblprinceEuro: UILabel!
    @IBOutlet weak var lblpriceDollar: UILabel!
    @IBOutlet weak var lblpriceYen: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getBitCoinProice()
    }
    
    func getBitCoinProice()
    {
        if let url = URL(string: "https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=USD,JPY,EUR")
        {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Double]
                        {
                            print(json)
                            DispatchQueue.main.async {
                                if let json = json["USD"]
                                {
                                    let value = self.currencyConverter(price: json, currencycode: "USD")
                                    self.lblpriceDollar.text=value
                                    
                                }
                                
                                if let json = json["EUR"]
                                {
                                    let value = self.currencyConverter(price: json, currencycode: "EUR")
                                    self.lblprinceEuro.text=value
                                    
                                }
                                
                                if let json = json["JPY"]
                                {
                                    let value = self.currencyConverter(price: json, currencycode: "JPY")
                                    self.lblpriceYen.text=value
                                    
                                }
                                
                            }
                        }
                        
                        
                        
                    } catch {
                        print("JSON error: \(error.localizedDescription)")
                    }
                    
                } else {
                    print("Something went wrong")
                }
            }.resume()
            
        }
        
    }
    
    func currencyConverter(price:Double,currencycode:String)-> String
    {
      let formatter=NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode=currencycode
        let formattedvalue = formatter.string(from: NSNumber(value: price))
      
        return formattedvalue!
        
    }
        
    @IBAction func btnRefreshTapped(_ sender: Any) {
        
        getBitCoinProice()
    }
}

