//
//  TextReqViewController.swift
//  DocDocGo
//
//  Created by Sunny Eltepu on 12/3/17.
//  Copyright © 2017 Sainigam Eltepu. All rights reserved.
//

import UIKit

class TextReqViewController: UIViewController {

    @IBOutlet var painLbl: UILabel!
    @IBOutlet var painSlider: UISlider!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var submitReqBtn: UIButton!
    @IBOutlet var addressTextField: UITextField!

    var sliderValToPass = Int()
    var descriptionToPass = String()
    var addressToPass = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // FOR KEYBOARD PUSHING VIEW UP
        NotificationCenter.default.addObserver(self, selector: #selector(TextReqViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(TextReqViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        // SLIDER STARTS IN THE MIDDLE (5)
        painSlider.value = 5.0;
        
        // DRAW BUTTON BORDERS
        submitReqBtn.backgroundColor = UIColor.clear
        submitReqBtn.layer.cornerRadius = 10
        submitReqBtn.layer.borderWidth = 2
        submitReqBtn.layer.borderColor = UIColor.gray.cgColor
        
        descriptionTextView.layer.cornerRadius = 5
        descriptionTextView.layer.borderWidth = 0.5
        descriptionTextView.layer.borderColor = UIColor.gray.cgColor
    }

    @IBAction func tappedSubmitReqBtn(_ sender: UIButton) {
        addressToPass = addressTextField.text!
        descriptionToPass = descriptionTextView.text
        performSegue(withIdentifier: "SummarySegue", sender: self)
    }
    
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        sliderValToPass = Int(sender.value)
        painLbl.text = String(sliderValToPass)
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y >= 0{
                self.view.frame.origin.y -= keyboardSize.height+50
            }
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y <= 0{
                self.view.frame.origin.y += keyboardSize.height-50
            }
        }
    }
    
    
    /*
     *  removes keyboard when background is touched
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        if let touch = touches.first {
            if descriptionTextView.isFirstResponder && (touch.view != descriptionTextView) {
                descriptionTextView.resignFirstResponder()
            }
            
            if addressTextField.isFirstResponder && (touch.view != addressTextField) {
                addressTextField.resignFirstResponder()
            }
        }
        super.touchesBegan(touches, with:event)
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
            
            // Obtain the object reference of the destination (downstream) view controller
            let reqSummaryViewController: ReqSummaryViewController = segue.destination as! ReqSummaryViewController
            
            // Pass the following data to downstream view controller VTPlaceOnMapViewController
            reqSummaryViewController.sliderValPassed = sliderValToPass
            reqSummaryViewController.descriptionPassed = descriptionToPass
            reqSummaryViewController.addressPassed = addressToPass

        }
    }
    
    

}
