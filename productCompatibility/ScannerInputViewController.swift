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
        
        print("#1: " + firstUPCStringNoZero)
        print("#2: " + firstUPCString)
        print("#3: " + secondUPCStringNoZero)
        print("#4: " + secondUPCString)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
        // Headers used for the HTTP requests.
        let headers = [
            "Accept": "application/vnd.productcompatibility.v1",
            "ContentType": "application/json"
        ]
    
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goingToFirstScanner" {
            print("We are going to the first Scanner!")
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
            print("We are going to the second Scanner!")
            let destinationController = segue.destinationViewController as! SecondScannerViewController
            if firstUPCStringNoZero.characters.count != 0 && firstUPCStringNoZero.characters.count == 12 {
                destinationController.firstUPCFromMenu = self.firstUPCStringNoZero
            } else if firstUPCString.characters.count != 0 && firstUPCString.characters.count == 12 {
                destinationController.firstUPCFromMenu = self.firstUPCString
            } else {
                //print("First UPC still has not been set")
                destinationController.firstUPCFromMenu = ""
            }
            
        } else {
            //print("This segue has not been given any extra features.")
        }
    }
    
}