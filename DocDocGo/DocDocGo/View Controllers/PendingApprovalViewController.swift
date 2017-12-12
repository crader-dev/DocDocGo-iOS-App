//
//  PendingApprovalViewController.swift
//  DocDocGo
//
//  Created by Sunny Eltepu on 12/10/17.
//  Copyright © 2017 Sainigam Eltepu. All rights reserved.
//

import UIKit

class PendingApprovalViewController: UIViewController {

    @IBOutlet var duckImgView: UIImageView!
    @IBOutlet var rotateBtn: UIButton!
    
    var waitTimePassed = String()
    var gotApproval = Int()
    var gameTimer: Timer!
    var requestIDPassed = Int()
    var requestStatus = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rotateBtn.layer.cornerRadius = 10
        
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
            performSegue(withIdentifier: "RequestDeniedSegue", sender: self)
            gameTimer.invalidate()
        }
        else if ( requestStatus == "TOUT" ) {
            print("REQUEST TIMED OUT")
            gameTimer.invalidate()
        } else {
            
            // POLL API AND GET STATUS
            var jsonDataHolder = Dictionary<String, AnyObject>()
            guard let url = URL(string: "http://34.199.76.53/api/v0/requests/\(requestIDPassed)") else { return }
            let session = URLSession.shared
            session.dataTask(with: url) { (data, response, err) in
            
//                if let response = response {
//                print(response)
//                }
                
                if let data = data {
//                print(data)
                    
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                        print(json!)
                        let dictionaryOfReturnedJsonData = json as! Dictionary<String, AnyObject>
                        jsonDataHolder = dictionaryOfReturnedJsonData
                        guard let currStatus: String = jsonDataHolder["status"] as? String else {return}    //  get status of request
//                        guard let currId: Int = jsonDataHolder["id"] as? Int else {return}                  //  get request id
                        
//                        print("CURR STATUS: \(currStatus) FOR ID: \(currId) ---------")
                        self.requestStatus = currStatus
                        
                    } catch {
                        print(err!)
                    }
                    
                }
            }.resume()
        }
    }
    
    @IBAction func rotateBtnTapped(_ sender: UIButton) {
        duckImgView.transform = duckImgView.transform.rotated(by: CGFloat(CGFloat.pi/2))
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
        
        if segue.identifier == "RequestAcceptedSegue" {}
        else if segue.identifier == "RequestDeniedSegue" {}
    }
}
