//
//  CompatibleProductsTableViewController.swift
//  productCompatibility
//
//  Created by Lozano Jimenez, Angel on 7/14/16.
//  Copyright © 2016 Best Buy, Inc. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CompatibleProductsTableViewController: UITableViewController {

    // Attributes for the Product Cell.
    
    var skuPassedByMainMenu: String?
    var localArrayOfProductArrays: [[JSON]] = []
    var swiftyJsonVar: JSON?
    var arrayOfSecondarySKUsAndUPCs: [String]!
    var arrayOfJSONEntries: [JSON] = []
    
    @IBOutlet weak var productImage: UIImageView!
    
    // Headers used for the HTTP requests.
    let headers = [
        "Accept": "application/vnd.productcompatibility.v1",
        "ContentType": "application/json"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        print("Count: \(self.localArrayOfProductArrays.count)")
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        tableView.estimatedRowHeight = 36.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.allowsSelection = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        // print("Entering didReceiveMemoryWarning.")
        // print("Leaving didReceiveMemoryWarning.")
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        // print("Entering numberOfSectionsInTableView.")
        // print("Leaving numberOfSectionsInTableView.")
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        // print("Entering tableView.")
        // print("Leaving tableView.")
        return self.localArrayOfProductArrays.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "productCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ProductTableViewCell
        // Configure the cell...
//        let url = NSURL(string: String(localArrayOfProductArrays[indexPath.row][4]))
//        let data = NSData(contentsOfURL: url!)
//        cell.productImage.image = UIImage(data: data!)
//        print("Image: \(url!)")

        if let url = NSURL(string: String(localArrayOfProductArrays[indexPath.row][4])), data = NSData(contentsOfURL: url) {
            cell.productImage.image = UIImage(data: data)
            print("Image: \(url)")
        } else {
            cell.productImage.image = UIImage(named: "Icon-60.png")
        }
        cell.nameLabel.text = String(localArrayOfProductArrays[indexPath.row][0])
        cell.skuLabel.text = String(localArrayOfProductArrays[indexPath.row][1])
        cell.manufacturerLabel.text = String(localArrayOfProductArrays[indexPath.row][2])
        cell.priceLabel.text = String(localArrayOfProductArrays[indexPath.row][3])
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
