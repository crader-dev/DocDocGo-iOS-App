//
//  ReqSummaryViewController.swift
//  DocDocGo
//
//  Created by Sunny Eltepu on 12/3/17.
//  Copyright © 2017 Sainigam Eltepu. All rights reserved.
//

import UIKit

class ReqSummaryViewController: UIViewController {

    @IBOutlet var waitTimeLbl: UILabel!
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var addressLbl: UILabel!
    @IBOutlet var painSeverityLbl: UILabel!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var okBtn: UIButton!
    @IBOutlet var cancelBtn: UIButton!
    
    var sliderValPassed = Int()
    var descriptionPassed = String()
    var namePassed = String()
    var addressPassed = String()
    var painLevelPassed = String()
    var longitudePassed = String()
    var latitudePassed = String()
    var waitTimeToPass = String()
    var requestIDToPass = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // DRAW BUTTON BORDERS
        okBtn.layer.cornerRadius = 10
        cancelBtn.layer.cornerRadius = 10
        descriptionTextView.layer.cornerRadius = 10
        
        nameLbl.text = namePassed
        addressLbl.text = addressPassed
        painSeverityLbl.text = painLevelPassed
        descriptionTextView.text = descriptionPassed
    }

    @IBAction func tappedOKBtn(_ sender: UIButton) {
        
        waitTimeToPass = waitTimeLbl.text!
        
        let params =  [
            "description": descriptionTextView.text!,
            "pain_severity": sliderValPassed,
            "latitude": latitudePassed,
            "longitude": longitudePassed
        ] as [String : Any]

        guard let url = URL(string: "http://34.199.76.53/api/v0/requests/") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else { return }
        request.httpBody = httpBody
        
        var tempIDHolder: Int = 0
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
                    let currId: Int = jsonDataHolder["id"] as! Int                  //  get request id
                    
                    print(jsonDataHolder)
                    tempIDHolder = currId;
                    self.requestIDToPass = tempIDHolder
                } catch {
                    print(error)
                }
            }
        }.resume()
        
        //  DELAY WHILE DATA IS ACCESSED
        while ( requestIDToPass == 0 ) {}
        requestIDToPass = tempIDHolder
        
        performSegue(withIdentifier: "PendingApprovalSegue", sender: self)
    }
    
    /*
     -----------------------------
     MARK: - Display Alert Message
     -----------------------------
     */
    func showAlertMessage(messageHeader header: String, messageBody body: String) {
        let alertController = UIAlertController(title: header, message: body, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
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
        
        if segue.identifier == "PendingApprovalSegue" {
            let pendingApprovalViewController: PendingApprovalViewController = segue.destination as! PendingApprovalViewController
            pendingApprovalViewController.waitTimePassed = waitTimeToPass
            pendingApprovalViewController.requestIDPassed = requestIDToPass
        }
    }
    
}
