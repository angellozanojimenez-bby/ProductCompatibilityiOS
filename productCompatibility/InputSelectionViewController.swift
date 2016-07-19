//
//  InputSelectionViewController.swift
//  productCompatibility
//
//  Created by Lozano Jimenez, Angel on 7/12/16.
//  Copyright © 2016 Best Buy, Inc. All rights reserved.
//

import UIKit
import Material
import Alamofire
import Alamofire_Synchronous
import SwiftyJSON

class InputSelectionViewController: UIViewController {

    @IBOutlet var inputSKU: TextField!
    var swiftyJsonVar: JSON?
    var arrayOfSecondarySKUsAndUPCs: [String]!
    var arrayOfJSONEntries: [JSON] = []
    var arrayOfProductArrays: [[JSON]] = []
    
    // Headers used for the HTTP requests.
    let headers = [
        "Accept": "application/vnd.productcompatibility.v1",
        "ContentType": "application/json"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ManualInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchCompatibleProducts() {

        if let sku = inputSKU.text {
            
            // Rails API call to obtain the relationships that have been created.
            let response = Alamofire.request(.GET, "http://api.productcompatibilityapi.dev/product_relationships/\(sku)", headers: headers).responseJSON()
            if let json = response.result.value {
                let swiftyJSON = JSON(json)
                for i in 0 ..< swiftyJSON.count {
                    let relationship = swiftyJSON[i]
                    self.arrayOfJSONEntries.append(relationship["relationships"]["secondary_node_sku_or_upc"])
                }
            }
            
            // String manipulation to create the query for the BBY API.
            var totalSKUString: String = ""
            for entry in self.arrayOfJSONEntries {
                if entry == self.arrayOfJSONEntries[self.arrayOfJSONEntries.count-1] {
                    totalSKUString += "sku=\(entry)"
                } else {
                    totalSKUString += "sku=\(entry)%7C"
                }
            }
            
            let secondResponse = Alamofire.request(.GET, "https://api.bestbuy.com/v1/products(\(totalSKUString))?apiKey=3nmxuf48rjc2jhxz7cwebcze&sort=name.asc&show=name,sku,manufacturer,salePrice,image&format=json").responseJSON()
            if let json = secondResponse.result.value {
                let productsJSON = JSON(json)
                for i in 0 ..< productsJSON["products"].count {
                    let productName = productsJSON["products"][i]["name"]
                    print("Product Name: \(productName)")
                    let productSKU = productsJSON["products"][i]["sku"]
                    print("Product SKU: \(productSKU)")
                    let productManufacturer = productsJSON["products"][i]["manufacturer"]
                    print("Product Manufacturer: \(productManufacturer)")
                    let productSalePrice = productsJSON["products"][i]["salePrice"]
                    print("Product Sale Price: \(productSalePrice)")
                    let productImage = productsJSON["products"][i]["image"]
                    print("Product Image: \(productImage)")
                    self.arrayOfProductArrays.append([productName, productSKU, productManufacturer, productSalePrice, productImage])
                }
            }
        }
    }

    @IBAction func unwindToMenu(segue: UIStoryboardSegue) {
        
    }

    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        searchCompatibleProducts()
        if segue.identifier == "toProductTableView" {
            
            let destinationController = segue.destinationViewController as! CompatibleProductsTableViewController

            if let sku = inputSKU.text {
                
                destinationController.skuPassedByMainMenu = sku
                destinationController.localArrayOfProductArrays = self.arrayOfProductArrays
                
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
