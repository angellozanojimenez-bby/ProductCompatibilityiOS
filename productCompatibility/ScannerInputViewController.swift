//
//  ScannerInputController.swift
//  productCompatibility
//
//  Created by Lozano Jimenez, Angel on 7/7/16.
//  Copyright © 2016 Best Buy, Inc. All rights reserved.
//

import UIKit
import Material
import Alamofire
import AVFoundation

class ScannerInputViewController: UIViewController {

    @IBOutlet var employeeNumber: TextField!
    @IBOutlet var notesInput: TextField!
    @IBOutlet var relationshipType: UISwitch!
    var firstUPCStringNoZero: String = ""
    var firstUPCString: String = ""
    var secondUPCStringNoZero: String = ""
    var secondUPCString: String = ""
    
    // Outlets to update the numbers that come back from the scanner.
    @IBOutlet weak var firstUPCLabel: UILabel!
    @IBOutlet weak var secondUPCLabel: UILabel!
    @IBOutlet weak var submitButton: RaisedButton!
    
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
        
        if firstUPCStringNoZero.characters.count == 12 {
            firstUPCLabel.text = "First UPC #" + firstUPCStringNoZero
        } else if firstUPCString.characters.count == 12 {
            firstUPCLabel.text = "First UPC #" + firstUPCString
        } else {
            firstUPCLabel.text = "First UPC #"
        }
        
        if secondUPCStringNoZero.characters.count == 12 {
            secondUPCLabel.text = "Second UPC #" + secondUPCStringNoZero
        } else if secondUPCString.characters.count == 12 {
            firstUPCLabel.text = "Second UPC #" + secondUPCString
        } else {
            secondUPCLabel.text = "Second UPC #"
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ScannerInputViewController.textChanged(_:)), name: UITextFieldTextDidChangeNotification, object: nil)
        submitButton.backgroundColor = UIColor.grayColor()
        submitButton.enabled = false
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    func textChanged(sender: NSNotification) {
        if firstUPCStringNoZero.isEmpty == false && secondUPCStringNoZero.isEmpty == false && employeeNumber.hasText() && notesInput.hasText() {
            submitButton.enabled = true
            submitButton.backgroundColor = UIColor(red: 0.0/255.0, green: 59.0/255.0, blue: 100.0/255.0, alpha: 1.0)
        } else {
            submitButton.enabled = false
        }
        
        
        if employeeNumber.hasText() {
            employeeNumber.detailColor = UIColor(red: 0.0/255.0, green: 178.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        }
        
        if notesInput.hasText() {
            notesInput.detailColor = UIColor(red: 0.0/255.0, green: 178.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        }
    }
    
    
    @IBAction func scanFirstUPC() {
        // Do whatever it takes to scan a UPC/barcode.
        // Take us to the ScannerController class.
        //print("In the ScannerController class now, looking for barcode. First.")
    }
    
    @IBAction func scanSecondUPC() {
        // Do whatever it takes to scan a UPC/barcode.
        // Take us to the ScannerController class.
        //print("In the ScannerController class now, looking for barcode. Second.")
    }

    @IBAction func createScannedRelationship() {
        // Create a relationship from the scanned products.
        
        // We must check if the attributes are present! If so, go into the loop and execute the HTTP methods.
        if self.firstUPCStringNoZero != "" && self.secondUPCStringNoZero != "" {
            if let employeeNumber = employeeNumber.text, let notes = notesInput.text {
                
                let parameters = [
                    "relationships": [
                        "primary_node_sku_or_upc":"\(self.firstUPCStringNoZero)",
                        "secondary_node_sku_or_upc":"\(self.secondUPCStringNoZero)", "employee_numbers":"\(employeeNumber)",
                        "notes":"\(notes)"
                        
                    
                    ]
                ]
                
                let incompatible_parameters = [
                    "incompatible_relationships": [
                        "primary_node_sku_or_upc":"\(self.firstUPCStringNoZero)",
                        "secondary_node_sku_or_upc":"\(self.secondUPCStringNoZero)", "employee_numbers":"\(employeeNumber)",
                        "notes":"\(notes)"
                        
                        
                    ]
                ]
                
                // Let's check what our parameters are.
                print("First UPC: " + self.firstUPCStringNoZero)
                print("Second UPC: " + self.secondUPCStringNoZero)
                print("Employee #: " + employeeNumber)
                print("Notes: " + notes)
                print("Compatible?: " + relationshipType.on.description)
                
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
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goingToFirstScanner" {
            let destinationController = segue.destinationViewController as! FirstScannerViewController
            if secondUPCStringNoZero.characters.count != 0 && secondUPCStringNoZero.characters.count == 12 {
                destinationController.secondUPCFromMenu = self.secondUPCStringNoZero
            } else if secondUPCString.characters.count != 0 && secondUPCString.characters.count == 12 {
                destinationController.secondUPCFromMenu = self.secondUPCString
            } else {
                destinationController.secondUPCFromMenu = ""
                //print("Second UPC still has not been set.")
            }
        } else if segue.identifier == "goingToSecondScanner" {
            let destinationController = segue.destinationViewController as! SecondScannerViewController
            if firstUPCStringNoZero.characters.count != 0 && firstUPCStringNoZero.characters.count == 12 {
                destinationController.firstUPCFromMenu = self.firstUPCStringNoZero
            } else if firstUPCString.characters.count != 0 && firstUPCString.characters.count == 12 {
                destinationController.firstUPCFromMenu = self.firstUPCString
            } else {
                destinationController.firstUPCFromMenu = ""
            }
            
        } else {
            //print("This segue has not been given any extra features.")
        }
    }
    
}