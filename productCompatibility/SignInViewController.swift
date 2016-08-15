//
//  SignInViewController.swift
//  productCompatibility
//
//  Created by Lozano Jimenez, Angel on 8/12/16.
//  Copyright © 2016 Best Buy, Inc. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CryptoSwift

class SignInViewController: UIViewController {
    
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var signInButton: UIButton!

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
    
    @IBAction func signInAction() {
        
        if let email = emailField.text, let password = passwordField.text {

            let encryptedPassword = password.md5()
            print("Encrypted Password: \(encryptedPassword)")
            
            Alamofire.request(.GET, "http://localhost:3000/users?email=\(email)", headers: headers)
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    switch response.result {
                    case .Success:
                        print("Validation Successful, Compatible Relationship created.")
                        let userResponse = JSON(response.result.value!)
                        if (String(userResponse["user_nodes"]["password"]) == encryptedPassword) {
                            self.performSegueWithIdentifier("successfulUserSignIn", sender: self)
                        } else {
                            let incorrectPasswordErrorController = UIAlertController(title: "Error", message: "Your email or password do not match our credentials, please try again.", preferredStyle: UIAlertControllerStyle.Alert)
                            let okayAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
                                print("Okay.")
                            }
                            incorrectPasswordErrorController.addAction(okayAction)
                            self.presentViewController(incorrectPasswordErrorController, animated: true, completion: nil)
                        }
                    case .Failure(let error):
                        print(error)
                        let emailErrorController = UIAlertController(title: "Error", message: "This email has not been registered yet, please check again.", preferredStyle: UIAlertControllerStyle.Alert)
                        let okayAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
                            print("Okay.")
                        }
                        emailErrorController.addAction(okayAction)
                        self.presentViewController(emailErrorController, animated: true, completion: nil)
                        
                    }
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
