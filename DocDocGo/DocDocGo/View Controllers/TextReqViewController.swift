//
//  TextReqViewController.swift
//  DocDocGo
//
//  Created by Sunny Eltepu on 12/3/17.
//  Copyright © 2017 Sainigam Eltepu. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // SLIDER STARTS IN THE MIDDLE (5)
        painSlider.value = 5.0;
        
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
        performSegue(withIdentifier: "SummarySegue", sender: self)
    }
    
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        painLbl.text = String(Int(sender.value))
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
        }
    }
}
