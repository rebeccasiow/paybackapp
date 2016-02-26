//
//  HomePageViewController.swift
//  Payback
//
//  Created by Kelly Stathis on 2/24/16.
//  Copyright © 2016 Kelly Stathis. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController, UITableViewDelegate { //FIXME need UITableDataSource

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func cellForRowAtIndexPath(indexPath: NSIndexPath) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCellWithIdentifier("expenseCell", forIndexPath: indexPath)
        cell.textLabel!.text = "\(indexPath.row)"
        print("indexing cells")
        return cell;
  
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return 1;
    }
    
    func numberOfSectionsInTableView() -> Int {
        return 5;
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
