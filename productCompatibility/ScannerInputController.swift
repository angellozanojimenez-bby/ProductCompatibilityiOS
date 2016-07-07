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

class ScannerInputController: UIViewController {

    @IBOutlet var employeeNumber: TextField!
    @IBOutlet var notesInput: TextField!
    @IBOutlet var relationshipType: UISwitch!
    
    @IBAction func scanFirstUPC() {
        // Do whatever it takes to scan a UPC/barcode.
    }

    @IBAction func scanSecondUPC() {
        // The same as the one above.
    }

    @IBAction func createScannedRelationship() {
        // Create a relationship from the scanned products.
    }
}