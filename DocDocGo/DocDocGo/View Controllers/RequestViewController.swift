//
//  RequestViewController.swift
//  DocDocGo
//
//  Created by Sunny Eltepu on 12/2/17.
//  Copyright © 2017 Sainigam Eltepu. All rights reserved.
//

import UIKit

class RequestViewController: UIViewController {

    @IBOutlet var textRequestBtn: UIButton!
    @IBOutlet var speechRequestBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textRequestBtn.backgroundColor = UIColor.clear
        textRequestBtn.layer.cornerRadius = 20
        textRequestBtn.layer.borderWidth = 2
        textRequestBtn.layer.borderColor = UIColor.gray.cgColor
        
        speechRequestBtn.backgroundColor = UIColor.clear
        speechRequestBtn.layer.cornerRadius = 20
        speechRequestBtn.layer.borderWidth = 2
        speechRequestBtn.layer.borderColor = UIColor.gray.cgColor
        
    }

    @IBAction func tappedTextReqBtn(_ sender: UIButton) {
        // Perform the segue named vtPlaceOnMap
        performSegue(withIdentifier: "TextRequestSegue", sender: self)
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
        
        if segue.identifier == "TextRequestSegue" {
            
            // Obtain the object reference of the destination (downstream) view controller
            let textReqViewController: TextReqViewController = segue.destination as! TextReqViewController
            
            // Pass the following data to downstream view controller VTPlaceOnMapViewController
//            textReqViewController.mapTypePassed = mapTypeToPass
//            textReqViewController.selectedBuildingNamePassed = selectedBuildingNamePassed
        }
    }
}
