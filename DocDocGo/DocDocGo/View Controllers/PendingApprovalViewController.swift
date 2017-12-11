//
//  PendingApprovalViewController.swift
//  DocDocGo
//
//  Created by Sunny Eltepu on 12/10/17.
//  Copyright © 2017 Sainigam Eltepu. All rights reserved.
//

import UIKit

class PendingApprovalViewController: UIViewController {

    var waitTimePassed = String()
    var gotApproval = Int()
    var gameTimer: Timer!
    var requestIDPassed = Int()
    var requestStatus = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(pollAPI), userInfo: nil, repeats: true)
        
    }

    @objc func pollAPI() {
        print("PASSED REQUEST ID: \(requestIDPassed)")
        if ( requestStatus == "CNFM" ) {
            print("GOT APPROVAL")
            performSegue(withIdentifier: "RequestAcceptedSegue", sender: self)
            gameTimer.invalidate()
        }
        else if ( requestStatus == "DENY" ) {
            print("DENIED")
            //            performSegue(withIdentifier: "RequestAcceptedSegue", sender: self)
            //            gameTimer.invalidate()
        }
        else if ( requestStatus == "TOUT" ) {
            print("REQUEST TIMED OUT")
            //            performSegue(withIdentifier: "RequestAcceptedSegue", sender: self)
            // alert here saying no doc found
            gameTimer.invalidate()
        }

        
        
        // POLL API AND GET STATUS
        var jsonDataHolder = Dictionary<String, AnyObject>()
        guard let url = URL(string: "http://34.199.76.53/api/v0/requests/\(requestIDPassed)") else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, err) in
        
            if let response = response {
//                print(response)
            }
            
            if let data = data {
//                print(data)
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                    print(json!)
                    let dictionaryOfReturnedJsonData = json as! Dictionary<String, AnyObject>
                    jsonDataHolder = dictionaryOfReturnedJsonData
                    guard let currStatus: String = jsonDataHolder["status"] as? String else {return}    //  get status of request
                    guard let currId: Int = jsonDataHolder["id"] as? Int else {return}                  //  get request id
                    
                    print("CURR STATUS: \(currStatus) FOR ID: \(currId) ---------")
//                    print("CURR ID: \(currId)")
                    self.requestStatus = currStatus
                    
                } catch {
                    print(err!)
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
    
    /*
     -------------------------
     MARK: - Prepare for Segue
     -------------------------
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        if segue.identifier == "RequestAcceptedSegue" {
            let requestAcceptedViewController: RequestAcceptedViewController = segue.destination as! RequestAcceptedViewController
//
//            // Pass the following data to downstream view controller
//            reqSummaryViewController.descriptionPassed = descriptionToPass
//            reqSummaryViewController.addressPassed = addressToPass
//            reqSummaryViewController.namePassed = nameToPass
//            reqSummaryViewController.painLevelPassed = painLevelToPass
        }
    }
}
