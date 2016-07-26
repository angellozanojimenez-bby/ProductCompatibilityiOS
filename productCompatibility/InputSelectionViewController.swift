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
import SwiftSpinner

class InputSelectionViewController: UIViewController {

    @IBOutlet var inputSKU: TextField!
    
    // For secondary node skus from Rails API.
    var arrayOfJSONEntries: [JSON] = []
    var secondArrayOfJSONEntries: [JSON] = []
    
    // For product info from BBY API.
    var arrayOfCompatibleProductArrays: [[JSON]] = []
    var arrayOfIncompatibleProductArrays: [[JSON]] = []
    
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
        self.navigationItem.setHidesBackButton(true, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searchCompatibleProducts() {
        SwiftSpinner.show("Loading...")
        if let sku = inputSKU.text {
            
            // Rails API call to obtain the relationships that have been created.
            let response = Alamofire.request(.GET, "http://api.productcompatibilityapi.dev/compatible_product_relationships/\(sku)", headers: headers).responseJSON()
            if let json = response.result.value {
                let swiftyJSON = JSON(json)
                for i in 0 ..< swiftyJSON.count {
                    let relationship = swiftyJSON[i]
                    self.arrayOfJSONEntries.append(relationship["relationships"]["secondary_node_sku"])
                    print("Compatible Secondary SKU: \(relationship["relationships"]["secondary_node_sku"])")
                }
            }

            let incompatibleResponse = Alamofire.request(.GET, "http://api.productcompatibilityapi.dev/incompatible_product_relationships/\(sku)", headers: headers).responseJSON()
            if let json = incompatibleResponse.result.value {
                let swiftyJSON = JSON(json)
                for i in 0 ..< swiftyJSON.count {
                    let relationship = swiftyJSON[i]
                    self.secondArrayOfJSONEntries.append(relationship["incompatible_relationships"]["secondary_node_sku"])
                    print("Incompatible Secondary SKU: \(relationship["incompatible_relationships"]["secondary_node_sku"])")
                }
            }
            
            // String manipulation to create the query for the BBY API.
            var totalCompatibleSKUString: String = ""
            for entry in self.arrayOfJSONEntries {
                if entry == self.arrayOfJSONEntries[self.arrayOfJSONEntries.count-1] {
                    totalCompatibleSKUString += "sku=\(entry)"
                } else {
                    totalCompatibleSKUString += "sku=\(entry)%7C"
                }
            }
            
            var totalIncompatibleSKUString: String = ""
            for entry in self.secondArrayOfJSONEntries {
                if entry == self.secondArrayOfJSONEntries[self.arrayOfJSONEntries.count-1] {
                    totalIncompatibleSKUString += "sku=\(entry)"
                } else {
                    totalIncompatibleSKUString += "sku=\(entry)%7C"
                }
            }
            
            print("Total SKU String of Compatible Products: \(totalCompatibleSKUString)")
            print("Total SKU String of Incompatible Products: \(totalIncompatibleSKUString)")
            
            // We pull from the BBY API to get the most updated picture, price and name?
            let compatibleProductResponse = Alamofire.request(.GET, "https://api.bestbuy.com/v1/products(\(totalCompatibleSKUString))?apiKey=3nmxuf48rjc2jhxz7cwebcze&sort=name.asc&show=name,sku,manufacturer,salePrice,thumbnailImage&format=json").responseJSON()
            if let json = compatibleProductResponse.result.value {
                let productsJSON = JSON(json)
                for i in 0 ..< productsJSON["products"].count {
                    let productName = productsJSON["products"][i]["name"]
                    //print("Product Name: \(productName)")
                    let productSKU = productsJSON["products"][i]["sku"]
                    //print("Product SKU: \(productSKU)")
                    let productManufacturer = productsJSON["products"][i]["manufacturer"]
                    //print("Product Manufacturer: \(productManufacturer)")
                    let productSalePrice = productsJSON["products"][i]["salePrice"]
                    //print("Product Sale Price: \(productSalePrice)")
                    let productImage = productsJSON["products"][i]["thumbnailImage"]
                    //print("Product Image: \(productImage)")
                    self.arrayOfCompatibleProductArrays.append([productName, productSKU, productManufacturer, productSalePrice, productImage])
                }
            }
            
            let incompatibleProductResponse = Alamofire.request(.GET, "https://api.bestbuy.com/v1/products(\(totalIncompatibleSKUString))?apiKey=3nmxuf48rjc2jhxz7cwebcze&sort=name.asc&show=name,sku,manufacturer,salePrice,thumbnailImage&format=json").responseJSON()
            if let json = incompatibleProductResponse.result.value {
                let productsJSON = JSON(json)
                for i in 0 ..< productsJSON["products"].count {
                    let productName = productsJSON["products"][i]["name"]
                    let productSKU = productsJSON["products"][i]["sku"]
                    let productManufacturer = productsJSON["products"][i]["manufacturer"]
                    let productSalePrice = productsJSON["products"][i]["salePrice"]
                    let productImage = productsJSON["products"][i]["thumbnailImage"]
                    self.arrayOfIncompatibleProductArrays.append([productName, productSKU, productManufacturer, productSalePrice, productImage])

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

        if segue.identifier == "toProductTableViews" {
            searchCompatibleProducts()
            let tabBarController = segue.destinationViewController as! UITabBarController
            let destinationViewControllerOne = tabBarController.viewControllers![0] as! CompatibleProductsViewController
            let destinationViewControllerTwo = tabBarController.viewControllers![1] as! IncompatibleProductsViewController
            
            if let sku = inputSKU.text {
                print("SKU: \(sku)")
                destinationViewControllerOne.localArrayOfProductArrays = self.arrayOfCompatibleProductArrays
                destinationViewControllerTwo.localArrayOfProductArrays = self.arrayOfIncompatibleProductArrays
            }
        }
    }
    
}
