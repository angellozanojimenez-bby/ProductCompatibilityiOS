//
//  MainMenuViewController.swift
//  productCompatibility
//
//  Created by Lozano Jimenez, Angel on 8/15/16.
//  Copyright © 2016 Best Buy, Inc. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // self.navigationController!.navigationBar.barTintColor = UIColor(red: 0.0/255.0, green: 59.0/255.0, blue: 100.0/255.0, alpha: 1.0)
        // Do any additional setup after loading the view.
        //self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().statusBarStyle = .LightContent

    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
        UIApplication.sharedApplication().statusBarStyle = .Default

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
