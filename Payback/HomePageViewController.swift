//
//  HomePageViewController.swift
//  Payback
//
//  Created by Kelly Stathis on 2/24/16.
//  Copyright © 2016 Kelly Stathis. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController,UITableViewDataSource, UITableViewDelegate  {
    
    var valueToPass: User
    
    required init(coder aDecoder: NSCoder) {
        self.valueToPass = User(id:-1, name:"dummy")
        super.init(coder: aDecoder)!
    }
    
    @IBOutlet weak var tableView: UITableView!
    static var userList:[User] = []
    static let userOfApp:User = User(id:0, name: "Me")
    let tess = User(id: 3, name: "Tess")
    let shefali = User(id: 1, name: "Shefali")
    let kelly = User(id: 2, name: "Kelly")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self;
        tableView.delegate = self;
        
        let rent = Expense(id: 1, name: "January rent", buyer: HomePageViewController.userOfApp, totalAmount: 300.00, owers: [kelly, tess])
        let groceries = Expense(id: 2, name: "Groceries", buyer: HomePageViewController.userOfApp, totalAmount: 15.00, owers: [shefali])
        let icecream = Expense(id: 3, name: "Ice cream", buyer: HomePageViewController.userOfApp, totalAmount: 30.00, owers: [kelly, tess])
        let burgers = Expense(id: 4, name: "Burgers", buyer: shefali, totalAmount: 30.00, owers: [HomePageViewController.userOfApp, tess])
        
       
        HomePageViewController.userOfApp.addAsBuyer(rent)
        kelly.addAsOwer(rent)
        tess.addAsOwer(rent)
        
        HomePageViewController.userOfApp.addAsBuyer(groceries)
        shefali.addAsOwer(groceries)
        
        HomePageViewController.userOfApp.addAsBuyer(icecream)
        kelly.addAsOwer(icecream)
        tess.addAsOwer(icecream)
        
        
        shefali.addAsBuyer(burgers)
        HomePageViewController.userOfApp.addAsOwer(burgers)
        tess.addAsOwer(burgers)
        
        
        HomePageViewController.userList = [shefali,kelly,tess]

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return HomePageViewController.userList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       /* let cell = tableView.dequeueReusableCellWithIdentifier("expenseCell", forIndexPath: indexPath)
        //cell.textLabel!.text = "\(indexPath.row)"
        return cell;
        */
        let cell = tableView.dequeueReusableCellWithIdentifier("expenseCell", forIndexPath: indexPath) as! expenseCell
        print("here")
        print(indexPath.row)
        let temp = HomePageViewController.userList[indexPath.row] as! User
        print(temp.name)
        
        let money = temp.getAmountOwedTo(HomePageViewController.userOfApp) - HomePageViewController.userOfApp.getAmountOwedTo(temp)
        
        if temp.name == "Kelly" {
            print("Kelly owes to user: " + String(temp.getAmountOwedTo(HomePageViewController.userOfApp)))
            print("User owes to Kelly: " + String(HomePageViewController.userOfApp.getAmountOwedTo(temp)))
        }
        
        
        cell.nameLabel?.text = temp.name
        cell.amountLabel?.text = "$" + String(money)
        
        return cell
        
    }
    

    
    /*func cellForRowAtIndexPath(tableView: UITableView, indexPath: NSIndexPath) -> UITableViewCell? {
       /* let cell = tableView.dequeueReusableCellWithIdentifier("expenseCell", forIndexPath: indexPath)
        cell.textLabel!.text = "\(indexPath.row)"
        print("indexing cells")
        return cell;
        */
        let cell = tableView.dequeueReusableCellWithIdentifier("expenseCell", forIndexPath: indexPath) as! expenseCell
        print("here")
        cell.nameLabel?.text = userList[indexPath.row].name
        print(userList[indexPath.row].name)
        
        return cell
  
    }*/
    /*
    func numberOfRowsInSection(tableView: UITableView!, section: Int) -> Int {
        return 1;
    }
*/

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        print("You selected cell #\(indexPath.row)!")
        
        // Get Cell Label
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRowAtIndexPath(indexPath)! as UITableViewCell
        
        valueToPass = HomePageViewController.userList[indexPath.row]
        performSegueWithIdentifier("itemizedExpenseView", sender: self)
        
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        if (segue.identifier == "itemizedExpenseView") {
            
            // initialize new view controller and cast it as your view controller
            let viewController = segue.destinationViewController as! ViewExpensesViewController
            // your new view controller should have property that will store passed value
            
            viewController.passedUser = valueToPass
        }
    }
    

}
