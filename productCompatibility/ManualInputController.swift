//
//  ViewController.swift
//  productCompatibility
//
//  Created by Lozano Jimenez, Angel on 7/1/16.
//  Copyright © 2016 Best Buy, Inc. All rights reserved.
//

import UIKit
import Material
import Alamofire

class ManualInputController: UIViewController {

    @IBOutlet var firstSKUnumber: TextField!
    @IBOutlet var secondSKUnumber: TextField!
    @IBOutlet var notesInput: TextField!
    @IBOutlet var employeeNumber: TextField!
    @IBOutlet var relationshipType: UISwitch!
    var BBYAPI = BBYAPIController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ManualInputController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func createManualRelationship() {
        print("You created a new manual relationship!")
        
        // Headers used for the HTTP requests.
        let headers = [
            "Accept": "application/vnd.productcompatibility.v1",
            "ContentType": "application/json"
        ]
        
        // We must check if the attributes are present! If so, go into the loop and execute the HTTP methods.
        if let firstSKU = firstSKUnumber.text, let secondSKU = secondSKUnumber.text, let employeeNumber = employeeNumber.text, let notes = notesInput.text {
            
            // We create the parameters that are going to be passed into the HTTP POST method.
            let parameters = [
                "relationships": [
                    "primary_node_sku":"\(firstSKU)",
                    "secondary_node_sku":"\(secondSKU)",
                    "employee_number":"\(employeeNumber)",
                    "notes":"\(notes)"
                ]
            ]

            let incompatible_parameters = [
                "incompatible_relationships": [
                    "primary_node_sku":"\(firstSKU)",
                    "secondary_node_sku":"\(secondSKU)",
                    "employee_number":"\(employeeNumber)",
                    "notes":"\(notes)"
                ]
            ]
            
            if relationshipType.on {
                // Here we create a POST method that takes in our headers and parameters and returns a message whether the method was successful or not.
                // Note that in this instance, the RelationshipType button is on, meaning that the products work with one another.
                Alamofire.request(.POST, "http://api.productcompatibilityapi.dev/relationships/", headers: headers, parameters: parameters)
                    .validate(statusCode: 200..<300)
                    .responseJSON { response in
                        switch response.result {
                        case .Success:
                            print("Validation Successful, Compatible Relationship created.")
                        case .Failure(let error):
                            print(error)
                        }
                }
            } else {
                // Here we create a POST method that takes in our headers and parameters and returns a message whether the method was successful or not.
                // Note that in this instance, the RelationshipType button is off, meaning that the products do not work with one another.
                Alamofire.request(.POST, "http://api.productcompatibilityapi.dev/incompatible_relationships/", headers: headers, parameters: incompatible_parameters)
                    .validate(statusCode: 200..<300)
                    .responseJSON { response in
                        switch response.result {
                        case .Success:
                            print("Validation Successful, Incompatible Relationship created.")
                        case .Failure(let error):
                            print(error)
                        }
                }
            }
        
            Alamofire.request(.GET, "https://api.bestbuy.com/v1/products(sku=\(firstSKU)?apiKey=3nmxuf48rjc2jhxz7cwebcze&sort=sku.asc&show=sku,name,manufacturer,salePrice,image&format=json")
                .responseJSON { response in
                    debugPrint(response)
            }
            
        }
        
        // Quickly get all of the relationships just to double check that everything worked and it was posted.
        Alamofire.request(.GET,  "http://api.productcompatibilityapi.dev/relationships/", headers: headers)
            .responseJSON { response in
                debugPrint(response)
        }
        
        Alamofire.request(.GET, "http://api.productcompatibilityapi.dev/incompatible_relationships/", headers: headers)
            .responseJSON { response in
                debugPrint(response)
        }
        
    }

}

