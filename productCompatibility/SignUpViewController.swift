//
//  SignUpViewController.swift
//  productCompatibility
//
//  Created by Lozano Jimenez, Angel on 8/12/16.
//  Copyright © 2016 Best Buy, Inc. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet var emailField: UITextField!
    @IBOutlet var employeeNumberField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var passwordConfirmationField: UITextField!
    @IBOutlet var signUpButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
