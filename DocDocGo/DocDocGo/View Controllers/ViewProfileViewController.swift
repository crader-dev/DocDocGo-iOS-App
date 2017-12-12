//
//  ViewProfileViewController.swift
//  DocDocGo
//
//  Created by Sunny Eltepu on 12/10/17.
//  Copyright © 2017 Sainigam Eltepu. All rights reserved.
//

import UIKit

class ViewProfileViewController: UIViewController {

    @IBOutlet var docImgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        docImgView.layer.cornerRadius = 10
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
