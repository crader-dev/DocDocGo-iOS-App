//
//  RequestsViewController.swift
//  DocDocGoDocApp
//
//  Created by Sunny Eltepu on 12/11/17.
//  Copyright © 2017 Sainigam Eltepu. All rights reserved.
//

import UIKit

class RequestsViewController: UIViewController {

    @IBOutlet var painLevelLbl: UILabel!
    @IBOutlet var descriptionTextView: UITextView!
    
    var gameTimer: Timer!
    var waiter = 0
    var painHolder = 0
    var descHolder = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(pollAPI), userInfo: nil, repeats: false)
    }
    
    @objc func pollAPI() {
        // POLL API AND GET STATUS
        guard let url = URL(string: "http://34.199.76.53/api/v0/requests/?responding_doctor=1") else { return }
//        guard let url = URL(string: "http://34.199.76.53/api/v0/requests/2/") else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, err) in

//            if let response = response {
////                print(response)
//            }
            
            if let data = data {
                print(data)
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    let dictionaryOfReturnedJsonData = json as! [Dictionary<String, AnyObject>]
                    let request_dict = dictionaryOfReturnedJsonData[0]
//                    print(request_dict["latitude"]!)
                    
                    while ( self.waiter == 0 ) {
                        if (request_dict["pain_severity"] == nil) {
                            self.waiter = 0
                        } else {
                            self.waiter = request_dict["pain_severity"] as! Int
                            self.descHolder = request_dict["description"] as! String
                        }
                    }
                    
                    self.painHolder = self.waiter
                    print(json)
                } catch {
                    print(err!)
                }
                
            }
        }.resume()
        
        while ( self.painHolder == 0 ) {}
        
        print("PAINHOLDER: \(self.painHolder)")
        print("DESCHOLDER: \(self.descHolder)")
        setLabels()
    }
    
    func setLabels() {
        painLevelLbl.text = "\(painHolder)"
        descriptionTextView.text = descHolder
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
