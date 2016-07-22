//
//  CompatibleProductsViewController.swift
//  productCompatibility
//
//  Created by Lozano Jimenez, Angel on 7/22/16.
//  Copyright © 2016 Best Buy, Inc. All rights reserved.
//

import UIKit
import SwiftyJSON

class CompatibleProductsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var compatibleProductsTableView: UITableView!
    // Double nested array sent from the Input Selection VC.
    var localArrayOfProductArrays: [[JSON]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Count In Compatible Products: \(self.localArrayOfProductArrays.count)")
        compatibleProductsTableView.estimatedRowHeight = 40.0
        compatibleProductsTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.localArrayOfProductArrays.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Set up the cell information.
        let cellIdentifier = "compatibleProductCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CompatibleProductTableViewCell
        
        // Set up the cell data.
        cell.nameLabel.text = String(localArrayOfProductArrays[indexPath.row][0])
        cell.skuLabel.text = String(localArrayOfProductArrays[indexPath.row][1])
        cell.manufacturerLabel.text = String(localArrayOfProductArrays[indexPath.row][2])
        cell.priceLabel.text = String(localArrayOfProductArrays[indexPath.row][3])

        let url = NSURL(string: String(localArrayOfProductArrays[indexPath.row][4]))
        let data = NSData(contentsOfURL: url!)
        cell.productImage.image = UIImage(data: data!)
        
        return cell
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