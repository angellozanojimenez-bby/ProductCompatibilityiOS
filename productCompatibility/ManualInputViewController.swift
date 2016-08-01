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

class ManualInputViewController: UIViewController {

    @IBOutlet var firstSKUnumber: TextField!
    @IBOutlet var secondSKUnumber: TextField!
    @IBOutlet var notesInput: TextField!
    @IBOutlet var employeeNumber: TextField!
    @IBOutlet var relationshipType: UISwitch!
    @IBOutlet weak var submitButton: RaisedButton!
    
    var BBYAPI = BBYAPIController()
    
    // Headers used for the HTTP requests.
    let headers = [
        "Accept": "application/vnd.productcompatibility.v1",
        "ContentType": "application/json"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ManualInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
        print("First SKU Number Type: " + String(firstSKUnumber.text!.dynamicType))
        print("Second SKU Number: " + secondSKUnumber.text!)
        print("Notes Input: " + notesInput.text!)
        print("Employee #: " + employeeNumber.text!)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ManualInputViewController.textChanged(_:)), name: UITextFieldTextDidChangeNotification, object: nil)
        submitButton.backgroundColor = UIColor.grayColor()
        submitButton.enabled = false
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
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
    
    func textChanged(sender: NSNotification) {
        if firstSKUnumber.hasText() && secondSKUnumber.hasText() && employeeNumber.hasText() && notesInput.hasText() {
            submitButton.enabled = true
            submitButton.backgroundColor = UIColor(red: 0.0/255.0, green: 59.0/255.0, blue: 100.0/255.0, alpha: 1.0)
        } else {
            submitButton.enabled = false
        }
        
        if firstSKUnumber.hasText() {
            firstSKUnumber.detailColor = UIColor(red: 0.0/255.0, green: 178.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        }
        
        if secondSKUnumber.hasText() {
            secondSKUnumber.detailColor = UIColor(red: 0.0/255.0, green: 178.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        }
        
        if employeeNumber.hasText() {
            employeeNumber.detailColor = UIColor(red: 0.0/255.0, green: 178.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        }
        
        if notesInput.hasText() {
            notesInput.detailColor = UIColor(red: 0.0/255.0, green: 178.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        }
    }
    
    @IBAction func createManualRelationship() {
        print("You created a new manual relationship!")
        
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
            
            // Let's check what our parameters are.
            print("First SKU: " + firstSKU)
            print("Second SKU: " + secondSKU)
            print("Employee #: " + employeeNumber)
            print("Notes: " + notes)
            print("Compatible?: " + relationshipType.on.description)
            
            if relationshipType.on {
                // Here we create a POST method that takes in our headers and parameters and returns a message whether the method was successful or not.
                // Note that in this instance, the RelationshipType button is on, meaning that the products work with one another.
                Alamofire.request(.POST, "http://40.77.61.2:3000/relationships/", headers: headers, parameters: parameters)
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
                Alamofire.request(.POST, "http://40.77.61.2:3000/incompatible_relationships/", headers: headers, parameters: incompatible_parameters)
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
            
        }
    }

}

