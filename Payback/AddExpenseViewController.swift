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
    
    let user0 = User(id: 0, name: "Shefali")
    let user1 = User(id: 1, name: "Becca")
    let user2 = User(id: 2, name: "Kelly")
    let user3 = User(id: 3, name: "Tess")
    let user4 = User(id: 4, name: "Silas")
    
    
    override func viewDidLoad() {
        print("HEOELOOELOEOOOOEOEOW ROLDS ")

        super.viewDidLoad()
    

        // Do any additional setup after loading the view.
        print("HEOELOOELOEOOOOEOEOW ROLDS ")

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
        
        var expense = Expense(id: 0, name: itemField.text!, buyer: foundBuyer!, totalAmount: Double(amountField.text!)!, owers:foundOwers)
        
        
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
