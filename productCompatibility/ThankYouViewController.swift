//
//  ThankYouViewController.swift
//  productCompatibility
//
//  Created by Lozano Jimenez, Angel on 7/12/16.
//  Copyright © 2016 Best Buy, Inc. All rights reserved.
//

import UIKit

class ThankYouViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func returnToHome(sender: AnyObject) {
        
        // We return to the scene with the specified "unwindToMenu" specifier.
        self.performSegueWithIdentifier("unwindToMenu", sender: self)
    
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
