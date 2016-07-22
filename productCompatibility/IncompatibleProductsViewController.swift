//
//  IncompatibleProductsViewController.swift
//  productCompatibility
//
//  Created by Lozano Jimenez, Angel on 7/22/16.
//  Copyright © 2016 Best Buy, Inc. All rights reserved.
//

import UIKit
import SwiftyJSON

class IncompatibleProductsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // Double nested array sent from the Input Selection VC.
    var localArrayOfProductArrays: [[JSON]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Count In Incompatible Products: \(self.localArrayOfProductArrays.count)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Set up the cell information.
        let cellIdentifier = "incompatibleProductCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
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
