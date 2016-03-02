//
//  HomePageViewController.swift
//  Payback
//
//  Created by Kelly Stathis on 2/24/16.
//  Copyright © 2016 Kelly Stathis. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController,UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var tableView: UITableView!
    var userList = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self;
        tableView.delegate = self;
        
        let user1 = User(id: 1, name: "Shefali")
        let user2 = User(id: 2, name: "Kelly")
        let user3 = User(id: 3, name: "Tess")
        let expense1 = Expense(id: 1, name: "Rent", payer: user1, totalAmount: 200.00, owers: [user2])
        let expense2 = Expense(id: 2, name: "Food", payer: user3, totalAmount: 15.00, owers: [user1])
        user1.addAsBuyer(expense1)
        user2.addAsOwer(expense1)
        user3.addAsBuyer(expense2)
        user2.addAsOwer(expense1)
        self.userList = [user1,user2,user3]

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return userList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("expenseCell", forIndexPath: indexPath)
        //cell.textLabel!.text = "\(indexPath.row)"
        return cell;
    }
    

    
    func cellForRowAtIndexPath(tableView: UITableView, indexPath: NSIndexPath) -> UITableViewCell? {
       /* let cell = tableView.dequeueReusableCellWithIdentifier("expenseCell", forIndexPath: indexPath)
        cell.textLabel!.text = "\(indexPath.row)"
        print("indexing cells")
        return cell;
        */
        let cell = tableView.dequeueReusableCellWithIdentifier("expenseCell", forIndexPath: indexPath)
        cell.textLabel?.text = userList[indexPath.item].name
        return cell
  
    }
    /*
    func numberOfRowsInSection(tableView: UITableView!, section: Int) -> Int {
        return 1;
    }
*/

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
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
