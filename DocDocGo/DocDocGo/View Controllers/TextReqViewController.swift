//
//  TextReqViewController.swift
//  DocDocGo
//
//  Created by Sunny Eltepu on 12/3/17.
//  Copyright © 2017 Sainigam Eltepu. All rights reserved.
//

import UIKit

class TextReqViewController: UIViewController {

    @IBOutlet var painSlider: UISlider!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var submitReqBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        performSegue(withIdentifier: "SummarySegue", sender: self)
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
        
        if segue.identifier == "SummarySegue" {
            
            // Obtain the object reference of the destination (downstream) view controller
            let _: ReqSummaryViewController = segue.destination as! ReqSummaryViewController
            
            // Pass the following data to downstream view controller VTPlaceOnMapViewController
            //            textReqViewController.mapTypePassed = mapTypeToPass
            //            textReqViewController.selectedBuildingNamePassed = selectedBuildingNamePassed
        }
    }

}
