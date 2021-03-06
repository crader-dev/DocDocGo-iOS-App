//
//  RequestsViewController.swift
//  DocDocGoDocApp
//
//  Created by Sunny Eltepu on 12/11/17.
//  Copyright © 2017 Sainigam Eltepu. All rights reserved.
//

import UIKit
import MapKit

class RequestsViewController: UIViewController {
    
    @IBOutlet var painLevelLbl: UILabel!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var acceptBtn: UIButton!
    @IBOutlet var denyBtn: UIButton!
    
    var gameTimer: Timer!
    var waiter = 0
    var painHolder = 0
    var descHolder = ""
    
    var ans_dict = [String: AnyObject]()
    
    var latitude: CLLocationDegrees = 00.0
    var longitude: CLLocationDegrees = 00.0
    var requestID = "0"
    var requestFound:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        acceptBtn.layer.cornerRadius = 10
        denyBtn.layer.cornerRadius = 10
        acceptBtn.isEnabled = false
        denyBtn.isEnabled = false
        
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(pollAPI), userInfo: nil, repeats: true)
    }
    
    @objc func pollAPI() {
        // POLL API AND GET STATUS
        guard let url = URL(string: "http://34.199.76.53/api/v0/requests/?responding_doctor=2&status=RQST") else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, err) in
            
            if let data = data {
                print(data)
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    let dictionaryOfReturnedJsonData = json as! [Dictionary<String, AnyObject>]
                    if ( dictionaryOfReturnedJsonData.isEmpty ) {
                        print("ISEMPTY")
                    } else {
                        self.requestFound = true
                        let request_dict = dictionaryOfReturnedJsonData[0]
                        
                        while ( self.waiter == 0) {
                            if (request_dict["pain_severity"] == nil) {
                                self.waiter = 0
                            } else {
                                self.waiter = request_dict["pain_severity"] as! Int
                                self.descHolder = request_dict["description"] as! String
                                self.ans_dict = request_dict
                            }
                        }
                        
                        self.painHolder = self.waiter
                        print(json)
                    }
                } catch {
                    print(err!)
                }
                
            }
            }.resume()
        
        if (requestFound) {
            // DELAY UNTIL JSON IS PARSED, THEN POPULATE VIEWS
            while ( self.painHolder == 0 ) {}
            setLabels()
        }
    }
    
    func setLabels() {
        painLevelLbl.text = "\(painHolder)"
        descriptionTextView.text = descHolder
        
        acceptBtn.isEnabled = true
        denyBtn.isEnabled = true
        
        self.latitude = CLLocationDegrees((ans_dict["latitude"] as! NSString).floatValue)
        self.longitude = CLLocationDegrees((ans_dict["longitude"] as! NSString).floatValue)
        let tempID = ans_dict["id"]
        self.requestID = "\(tempID ?? 0 as AnyObject)"
        
        print(requestID)
        
        print(ans_dict)
        print(self.latitude)
        print(self.longitude)
    }
    
    
    @IBAction func acceptBtnTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "CompleteApptSegue", sender: self)
        openMapForPlace()
        
        
        let params =  [
            "status": "CNFM"
            ] as [String : Any]
        
        guard let url = URL(string: "http://34.199.76.53/api/v0/requests/\(requestID)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else { return }
        request.httpBody = httpBody
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
    
    @IBAction func denyBtnTapped(_ sender: UIButton) {
        let params =  [
            "status": "RFUS"
            ] as [String : Any]
        
        guard let url = URL(string: "http://34.199.76.53/api/v0/requests/\(requestID)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else { return }
        request.httpBody = httpBody
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
        
//        self.showAlertMessage(messageHeader: "Request Denied",
//                                  messageBody: "You have denied this request.")
    }
    
    @IBAction func unwindFromCompleteAppt(_ sender: UIStoryboardSegue) {
        self.requestFound = false
        self.waiter = 0
        
    }
    
    func resetLabels() {
        acceptBtn.isEnabled = false
        denyBtn.isEnabled = false
        
        painLevelLbl.text = "0"
        descriptionTextView.text = "You have no requests!"
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
     * OPENS MAPS based on location -> for directions
     */
    func openMapForPlace() {
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Client Location"
        mapItem.openInMaps(launchOptions: options)
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
        
        if segue.identifier == "CompleteApptSegue" {
            let completeApptViewController: CompleteApptViewController = segue.destination as! CompleteApptViewController
            completeApptViewController.requestIDPassed = requestID
        }
    }
    
}

