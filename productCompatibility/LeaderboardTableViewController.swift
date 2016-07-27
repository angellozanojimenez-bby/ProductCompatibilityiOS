//
//  LeaderboardTableViewController.swift
//  productCompatibility
//
//  Created by Lozano Jimenez, Angel on 7/27/16.
//  Copyright © 2016 Best Buy, Inc. All rights reserved.
//

import UIKit

class LeaderboardTableViewController: UITableViewController {

    var fakeEmployeeID: [Int] = [1197564, 11223344, 12131415, 12213141, 19912874, 23458901, 23321212, 10079091]
    var fakeEmployeeScores: [Int] = [1000, 900, 800, 700, 600, 500, 400, 300, 200]
    var fakeEmployeePicures: [String] = ["angel.jpg", "grant.jpg", "jonathan.jpg", "lane.jpg", "tony.jpg", "quan.jpg","shawn.jpg", "andrey.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        title = "Leaderboard"
        tableView.estimatedRowHeight = 40.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fakeEmployeeID.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // This is the custom cell from the Table View.
        let cell = tableView.dequeueReusableCellWithIdentifier("leaderboardCell", forIndexPath: indexPath) as! LeaderboardTableViewCell
        // Edit the cell.
        cell.employeeID.text = String(fakeEmployeeID[indexPath.row])
        cell.employeeScore.text = String(fakeEmployeeScores[indexPath.row])
        cell.imageView!.image = UIImage(named: fakeEmployeePicures[indexPath.row])
        cell.imageView!.layer.cornerRadius = 37.5
        cell.imageView!.clipsToBounds = true
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
