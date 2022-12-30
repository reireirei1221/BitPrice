//
//  Function.swift
//  BitPrice Watch App
//
//  Created by 澤野令 on 2022/12/26.
//

import Foundation

class BitCoin: NSObject, ObservableObject {
    
    @Published var priceLabel = ""
    @Published var updatingLabel = "Updating..."
    
    func getPrice() {
        let url = URL(string: "https://api.coindesk.com/v1/bpi/currentprice.json")!
        
        URLSession.shared.dataTask (with: url) { (data:Data?, response:URLResponse?, error:Error?) in
            if error == nil {
                print("It worked")
                
                if data != nil {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]

                        guard let bpi = json["bpi"] as? [String:Any], let USD = bpi["USD"] as? [String:Any], let price = USD["rate_float"] as? Float64 else {
                            print("It's broke!")
                            return
                        }
                        
                        let formatter = NumberFormatter()
                        formatter.numberStyle = .currency
                    
                        formatter.locale = Locale(identifier: "en_US")
                    
                        self.priceLabel = formatter.string(from: price as NSNumber)!
                        self.updatingLabel =  "Updated"
                        
//                        UserDefaults.standard.set(price, forKey: "price")
//                        UserDefaults.standard.synchronize()
                        
                    } catch {}
                }
            } else {
                print("It's broke!")
            }
        }
        .resume()
    }
}
