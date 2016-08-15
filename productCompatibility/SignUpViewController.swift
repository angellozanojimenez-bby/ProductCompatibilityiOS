//
//  SignUpViewController.swift
//  productCompatibility
//
//  Created by Lozano Jimenez, Angel on 8/12/16.
//  Copyright © 2016 Best Buy, Inc. All rights reserved.
//

import UIKit
import Alamofire

class SignUpViewController: UIViewController {
    
    @IBOutlet var emailField: UITextField!
    @IBOutlet var employeeNumberField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var passwordConfirmationField: UITextField!
    @IBOutlet var signUpButton: UIButton!
    
    // Headers used for the HTTP requests.
    let headers = [
        "Accept": "application/vnd.productcompatibility.v1",
        "ContentType": "application/json"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpAction() {
        
        if let email = emailField.text, let employeeNumber = employeeNumberField.text, let password = passwordField.text, let passwordConfirmation = passwordConfirmationField.text {
            if password == passwordConfirmation {
                print("Email: \(email)")
                print("Employee #: \(employeeNumber)")
            } else {
                let passwordErrorController = UIAlertController(title: "Error!", message: "Passwords do not match, please try again.", preferredStyle: UIAlertControllerStyle.Alert)
                let okayAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
                    print("Okay.")
                }
                passwordErrorController.addAction(okayAction)
                self.presentViewController(passwordErrorController, animated: true, completion: nil)
            }
        }
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
