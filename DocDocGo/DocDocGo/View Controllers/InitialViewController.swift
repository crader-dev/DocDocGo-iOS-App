//
//  InitialViewController.swift
//  DocDocGo
//
//  Created by Sunny Eltepu on 12/3/17.
//  Copyright © 2017 Sainigam Eltepu. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    @IBOutlet var textReqBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // DRAW BUTTON BORDERS
        textReqBtn.layer.cornerRadius = 10
    }

    @IBAction func tappedTextReqBtn(_ sender: UIButton) {
        performSegue(withIdentifier: "TextReqSegue", sender: self)
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
        
        if segue.identifier == "TextReqSegue" {}
    }

}
