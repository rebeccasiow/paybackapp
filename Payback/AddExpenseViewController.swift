//
//  AddExpenseViewController.swift
//  Payback
//
//  Created by Rebecca Siow on 3/2/16.
//  Copyright © 2016 Kelly Stathis. All rights reserved.
//

import UIKit

class AddExpenseViewController: UIViewController {
    @IBOutlet weak var itemField: UITextField!
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var buyerField: UITextField!
    @IBOutlet weak var owerField: UITextField!
    var doneButton = UIButton()
    
    let user0 = User(id: 0, name: "Shefali")
    let user1 = User(id: 1, name: "Becca")
    let user2 = User(id: 2, name: "Kelly")
    let user3 = User(id: 3, name: "Tess")
    let user4 = User(id: 4, name: "Silas")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    

        // Do any additional setup after loading the view.

        let shefalisUsers: [User] = [user0, user1, user2, user3, user4]
        
        let shefalisExpense = Expense(id: 0, name: "pencils", buyer: user0, totalAmount: 5.0, owers: shefalisUsers)
        
        do {
            var user0owesShefali = 0.0
            user0owesShefali = try shefalisExpense.getAmountOwed(user0)
            print(user0owesShefali)
        } catch ExpenseError.userNotInvolved {
            print("Error: User Not Involved in Transaction.")
        } catch{
            print("Error: General.")
        }
    }
    
    @IBAction func doneButtonPressed(sender: AnyObject) {
        
        print("done button pressed")
        var foundOwers = [User]()
        var foundBuyer:User? = nil
        for user in HomePageViewController.userList {
            if user.name == owerField.text {
                foundOwers.append(user)
            }
            if (user.name == buyerField.text) {
                foundBuyer = user
            }
        }
        
        if (itemField.text == nil || itemField.text == "") {
            // popup "fail"
            showPopUp("Enter Expense Name")
            return
        }
        
        //if any important fields are nil, invalid
        if foundBuyer == nil {
            //popup "we couldnt find that buyer"
            showPopUp("We couldn't find that user!")
            return
            
        } else if foundOwers.count == 0 {
            // popup "we coulndt..."
            showPopUp("We couldn't find that user!")
            return
        }
        let amountOpt = Double(amountField.text!)
        if amountOpt == nil {
            // popup "invalid amount"
            showPopUp("Invalid Amount!")
            return
        }
        let amount = amountOpt!
        
        let expense = Expense(id: 0, name: itemField.text!, buyer: foundBuyer!, totalAmount: amount, owers:foundOwers)
        
        for user in foundOwers {
            user.expensesWhereIsOwer.append(expense)
        }
        foundBuyer!.expensesWhereIsBuyer.append(expense)
        
    }
    
    func showPopUp(message : String){
        
        let alert = UIAlertController(title: "Info Missing", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default)
            {
                (UIAlertAction) -> Void in
            }
        alert.addAction(alertAction)
        presentViewController(alert, animated: true)
            {
                () -> Void in 
            }

        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
