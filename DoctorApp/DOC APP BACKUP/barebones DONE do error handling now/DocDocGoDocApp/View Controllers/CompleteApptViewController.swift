//
//  CompleteApptViewController.swift
//  DocDocGoDocApp
//
//  Created by Sunny Eltepu on 12/11/17.
//  Copyright © 2017 Sainigam Eltepu. All rights reserved.
//

import UIKit

class CompleteApptViewController: UIViewController {

    var requestIDPassed = String()
    
    @IBOutlet var completeApptBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        completeApptBtn.layer.cornerRadius = 10
    }

    @IBAction func completeApptTapped(_ sender: UIButton) {
        print("APPOINTMENT COMPLETE")
        let params =  [
            "status": "COMP"
            ] as [String : Any]
        
        guard let url = URL(string: "http://34.199.76.53/api/v0/requests/\(requestIDPassed)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else { return }
        request.httpBody = httpBody
        //        //
        //        var tempIDHolder: Int = 0
        var jsonDataHolder = Dictionary<String, AnyObject>()
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                print(data)
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    let dictionaryOfReturnedJsonData = json as! Dictionary<String, AnyObject>
                    
                    jsonDataHolder = dictionaryOfReturnedJsonData
                    print(jsonDataHolder)
                } catch {
                    print(error)
                }
            }
        }.resume()
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
