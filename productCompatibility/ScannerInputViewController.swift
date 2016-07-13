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
    var firstUPCstringNoZero: String = ""
    var firstUPCstring: String = ""
    var secondUPCstringNoZero: String = ""
    var secondUPCstring: String = ""
    
    // Outlets to update the numbers that come back from the scanner.
    @IBOutlet weak var firstUPCLabel: UILabel!
    @IBOutlet weak var secondUPCLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ManualInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
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
        print("In the ScannerController class now, looking for barcode. First.")
    }
    @IBAction func scanSecondUPC() {
        // Do whatever it takes to scan a UPC/barcode.
        // Take us to the ScannerController class.
        print("In the ScannerController class now, looking for barcode. Second.")
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
    
}