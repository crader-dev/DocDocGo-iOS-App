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
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var okBtn: UIButton!
    @IBOutlet var cancelBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // DRAW BUTTON BORDERS
        okBtn.backgroundColor = UIColor.clear
        okBtn.layer.cornerRadius = 10
        okBtn.layer.borderWidth = 2
        okBtn.layer.borderColor = UIColor.blue.cgColor
        
        cancelBtn.backgroundColor = UIColor.clear
        cancelBtn.layer.cornerRadius = 10
        cancelBtn.layer.borderWidth = 2
        cancelBtn.layer.borderColor = UIColor.red.cgColor
        
        descriptionTextView.layer.cornerRadius = 5
        descriptionTextView.layer.borderWidth = 0.5
        descriptionTextView.layer.borderColor = UIColor.gray.cgColor
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

    
}
