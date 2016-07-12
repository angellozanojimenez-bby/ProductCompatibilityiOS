//
//  BBYAPI.swift
//  productCompatibility
//
//  Created by Lozano Jimenez, Angel on 7/6/16.
//  Copyright © 2016 Best Buy, Inc. All rights reserved.
//

import Alamofire

class BBYAPIController {
    
    func getBBYJSONproductbySKU(sku: String) {
        Alamofire.request(.GET, "https://api.bestbuy.com/v1/products(sku=\(sku)?apiKey=3nmxuf48rjc2jhxz7cwebcze&sort=sku.asc&show=sku,name,manufacturer,salePrice,image&format=json")
            .responseJSON { response in
                debugPrint(response)
        }
    }
    
    func getBBYJSONproductbyUPC(upc: String) {
        Alamofire.request(.GET, "https://api.bestbuy.com/v1/products(upc=\(upc)?apiKey=3nmxuf48rjc2jhxz7cwebcze&sort=sku.asc&show=sku,name,manufacturer,salePrice,image&format=json")
            .responseJSON { response in
                debugPrint(response)
        }
    }
    
}