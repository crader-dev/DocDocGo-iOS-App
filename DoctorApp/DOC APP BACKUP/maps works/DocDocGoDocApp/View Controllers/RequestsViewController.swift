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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        acceptBtn.isEnabled = false
        denyBtn.isEnabled = false
        
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(pollAPI), userInfo: nil, repeats: false)
    }
    
    @objc func pollAPI() {
        // POLL API AND GET STATUS
        guard let url = URL(string: "http://34.199.76.53/api/v0/requests/?responding_doctor=1") else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, err) in
            
            if let data = data {
                print(data)
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    let dictionaryOfReturnedJsonData = json as! [Dictionary<String, AnyObject>]
                    let request_dict = dictionaryOfReturnedJsonData[0]
                    
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
        
        acceptBtn.isEnabled = true
        denyBtn.isEnabled = true

    }
    
    
    @IBAction func acceptBtnTapped(_ sender: UIButton) {
//        performSegue(withIdentifier: "DirectionsSegue", sender: self)
        openMapForPlace()
    }
    
    @IBAction func denyBtnTapped(_ sender: UIButton) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func openMapForPlace() {
        
        let latitude: CLLocationDegrees = 37.2
        let longitude: CLLocationDegrees = 22.9
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Place Name"
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
        
        if segue.identifier == "DirectionsSegue" {
            let directionsViewController: DirectionsViewController = segue.destination as! DirectionsViewController
            //
            //            // Pass the following data to downstream view controller
            //            reqSummaryViewController.descriptionPassed = descriptionToPass
            //            reqSummaryViewController.addressPassed = addressToPass
            //            reqSummaryViewController.namePassed = nameToPass
            //            reqSummaryViewController.painLevelPassed = painLevelToPass
        }
    }
    
}
