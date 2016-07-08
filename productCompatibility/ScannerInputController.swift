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

class ScannerInputController: UIViewController {

    @IBOutlet var employeeNumber: TextField!
    @IBOutlet var notesInput: TextField!
    @IBOutlet var relationshipType: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ManualInputController.dismissKeyboard))
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
    }

    @IBAction func scanSecondUPC() {
        // The same as the one above.
    }

    @IBAction func createScannedRelationship() {
        // Create a relationship from the scanned products.
        print("You created a new scanned relationship!")
        
        // Headers used for the HTTP requests.
        let headers = [
            "Accept": "application/vnd.productcompatibility.v1",
            "ContentType": "application/json"
        ]
    }
}