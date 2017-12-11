//
//  TextReqViewController.swift
//  DocDocGo
//
//  Created by Sunny Eltepu on 12/3/17.
//  Copyright © 2017 Sainigam Eltepu. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class TextReqViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var painLbl: UILabel!
    @IBOutlet var painSlider: UISlider!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var submitReqBtn: UIButton!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var addressTextField: UITextField!
    
    var addressToPass = String()
    var nameToPass = String()
    var painLevelToPass = String()
    var descriptionToPass = String()
    var sliderValToPass = Int()
    var latitudeToPass = String()
    var longitudeToPass = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // SLIDER STARTS IN THE MIDDLE (5)
        painSlider.value = 5.0
        sliderValToPass = 5
        
        // DRAW BUTTON BORDERS
        submitReqBtn.layer.cornerRadius = 10
        descriptionTextView.layer.cornerRadius = 5
    }

    @IBAction func tappedSubmitReqBtn(_ sender: UIButton) {
//        if ( nameTextField.text == "" ) {
//            self.showAlertMessage(messageHeader: "No Name Specified!",
//                                  messageBody: "Please enter your name!")
//        }
//
//        if ( addressTextField.text == "" ) {
//            self.showAlertMessage(messageHeader: "No Address Specified!",
//                                  messageBody: "Please enter your current address!")
//        }
//
//        if ( descriptionTextView.text == "" ) {
//            self.showAlertMessage(messageHeader: "No Description Provided!",
//                                  messageBody: "Please enter a short description of your emergency!")
//        }
//
        nameToPass = nameTextField.text!
        addressToPass = addressTextField.text!
        descriptionToPass = descriptionTextView.text
        painLevelToPass = painLbl.text!
        
        //******************
        // GET LATITUDE AND LONGITUDE WITH GEOCODER
        //******************
        
        // Instantiate a forward geocoder object
        let forwardGeocoder = CLGeocoder()
        
        /*
         Ask the forward geocoder object to
         (a) execute its geocodeAddressString method in a new thread *** asynchronously ***
         (b) determine the geolocation (latitude, longitude) of the given address, and
         (c) give the results to the completion handler function geocoderCompletionHandler running under the main thread.
         */
        forwardGeocoder.geocodeAddressString(addressToPass) { (placemarks, error) in
            self.geocoderCompletionHandler(withPlacemarks: placemarks, error: error)
        }
        
        // statments after this may not process becauses of asynchronous processing, so put the perform segue in teh
        // completion handler
    }
    
    /*
     ---------------------------------
     MARK: - Process Geocoding Results
     ---------------------------------
     */
    private func geocoderCompletionHandler(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        
        if let errorOccurred = error {
            self.showAlertMessage(messageHeader: "Forward Geocoding Unsuccessful!",
                                  messageBody: "Forward Geocoding of the Given Address Failed: (\(errorOccurred))")
            return
        }
        
        var geolocation: CLLocation?
        
        if let placemarks = placemarks, placemarks.count > 0 {
            geolocation = placemarks.first?.location
        }
        
        if let locationObtained = geolocation {
            
            self.latitudeToPass = String(locationObtained.coordinate.latitude)
            self.longitudeToPass = String(locationObtained.coordinate.longitude)
            
            print(self.latitudeToPass)
            print(self.longitudeToPass)
            
        } else {
            self.showAlertMessage(messageHeader: "Location Match Failed!",
                                  messageBody: "Unable to Find a Matching Location!")
            return
        }
        
        performSegue(withIdentifier: "SummarySegue", sender: self)
    }
    
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        painLbl.text = String(Int(sender.value))
        sliderValToPass = Int(sender.value)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        if segue.identifier == "SummarySegue" {
            let reqSummaryViewController: ReqSummaryViewController = segue.destination as! ReqSummaryViewController
            
            // Pass the following data to downstream view controller
            reqSummaryViewController.descriptionPassed = descriptionToPass
            reqSummaryViewController.addressPassed = addressToPass
            reqSummaryViewController.namePassed = nameToPass
            reqSummaryViewController.painLevelPassed = painLevelToPass
            reqSummaryViewController.sliderValPassed = sliderValToPass
            reqSummaryViewController.longitudePassed = longitudeToPass
            reqSummaryViewController.latitudePassed = latitudeToPass
        }
    }
}
