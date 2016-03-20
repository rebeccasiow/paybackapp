//
//  ViewExpensesViewController.swift
//  Payback
//
//  Created by Kelly Stathis on 3/7/16.
//  Copyright © 2016 Kelly Stathis. All rights reserved.
//

import UIKit

class ViewExpensesViewController: UITableViewController {
    var passedUser: User!
    var friendExpenses: [Expense]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(passedUser.name)
        var tempExpenses: [Expense]
        for expense in HomePageViewController.userOfApp.expensesWhereIsBuyer {
            //  Get expenses where passedUser is ower
            var amountOwed: Double
            do {
                try amountOwed = expense.getAmountOwed(passedUser)
            }
            catch {
                amountOwed = 0
            }
            if (amountOwed > 0) {
                friendExpenses.append(expense)
                print(expense.name)
                print(expense.amountOwed)
                print("owed by passedUser")
            }

        }
        for expense in passedUser.expensesWhereIsBuyer {
            // Get expenses where userOfApp is ower
            var amountOwed: Double
            do {
                try amountOwed = expense.getAmountOwed(HomePageViewController.userOfApp)
            }
            catch {
                amountOwed = 0
            }
            if (amountOwed > 0) {
                friendExpenses.append(expense)
                print(expense.name)
                print(expense.amountOwed)
                print("owed by userOfApp")
            }
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //friendExpenses[]
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return friendExpenses.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("expenseCell", forIndexPath: indexPath) as! expenseCell
        print("gets to cellForRow")
        //cell.textLabel!.text = HomePageViewController.userList[indexPath.row].name
        //cell.textLabel!.text = passedUser.name
        
        let temp = friendExpenses[indexPath.row]
        print(temp.name)
        cell.nameLabel?.text = temp.name
        
        print("temp: " + temp.name + " " + temp.buyer.name + " " + String(temp.totalAmount))
        for (User, Double) in temp.amountOwed {
            print("user: " + User.name + " amount: " + String(Double))
        }
        
        if (temp.buyer == HomePageViewController.userOfApp) {
            do {
                try cell.amountLabel?.text = "$" + String(temp.amountOwed[passedUser]!)
            } catch {
                cell.amountLabel?.text = String(0)
            }
        }
        else {
            do {
                try cell.amountLabel?.text = "-$" + String(temp.getAmountOwed(HomePageViewController.userOfApp))
            } catch {
                cell.amountLabel?.text = String(0)
            }
        }

        // Configure the cell...
        
        

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
