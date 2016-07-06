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

class ViewController: UIViewController {

    @IBOutlet var firstSKUnumber: TextField!
    @IBOutlet var secondSKUnumber: TextField!
    @IBOutlet var notesInput: TextField!
    @IBOutlet var employeeNumber: TextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            // Here we create a POST method that takes in our headers and parameters and returns a message whether the method was successful or not.
            Alamofire.request(.POST, "http://api.productcompatibilityapi.dev/relationships/", headers: headers, parameters: parameters)
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    switch response.result {
                    case .Success:
                        print("Validation Successful")
                    case .Failure(let error):
                        print(error)
                    }
            }
            // Quickly get all of the relationships just to double check that everything worked and it was posted.
            Alamofire.request(.GET,  "http://api.productcompatibilityapi.dev/relationships/", headers: headers)
                .responseJSON { response in
                    debugPrint(response)
            }
        
        }
    
    }

}

