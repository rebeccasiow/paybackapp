//
//  Expense.swift
//  Payback
//
//  Created by Kelly Stathis on 2/29/16.
//  Copyright © 2016 Kelly Stathis. All rights reserved.
//

import Foundation

/**
Exceptions for when an expense is added:
1. if getAmountOwed function is called on a user not involved in the transaction
result: return -1
2. same for getAmountPaid
3. If parts of the Add Expense form is not complete --> red pop-up


///////////////////
insertExpense class would contain something like:

var expense1 = Expense(id:Int, name:String, payer:User, totalAmount:Double, owers:[User], amountOwed:[User : Double],amountPaid:[User : Double])

do {  //getExpense is example function
try getExpense("John", Expense: Expense)
} catch ExpenseError.userNotInvolved {
print("User Not Involved in Transaction.")
} catch ExpenseError.incompleteForm
 {
print("Incomplete Form.")
} catch ExpenseError.userNotInSystem(let coinsNeeded) {
print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
}

**/


enum ExpenseError: ErrorType {
    case userNotInvolved
    case incompleteForm
    case userNotInSystem
}

class Expense {
    var id:Int
    var name:String
    var buyer:User
    var totalAmount:Double
    var owers:[User]
    var amountOwed:[User : Double]
    var amountPaid:[User : Double]
    
    init(id:Int, name:String, buyer:User, totalAmount:Double, owers:[User], amountOwed:[User : Double],amountPaid:[User : Double]) {
        self.id = id
        self.name = name
        self.buyer = buyer
        self.totalAmount = totalAmount
        self.owers = owers
        self.amountOwed = amountOwed
        self.amountPaid = amountPaid
        
        ModelManager.getInstance().addExpenseData(self) //id, name, payer, totalAmount
        for user in owers[0..<owers.count] {
            ModelManager.getInstance().addOwedPaidData(self, userInfo: user) //owers, amountOwed, //amountPaid
        }

    }
    
    init(id:Int, name:String, buyer:User, totalAmount:Double, owers:[User]) {
        
        self.id = id
        self.name = name
        self.buyer = buyer
        self.totalAmount = totalAmount
        self.owers = owers
        let owerCount = owers.count
        let autosplit = totalAmount/Double(owerCount)
        amountOwed = [User : Double]()
        amountPaid = [User : Double]()
        ModelManager.getInstance().addExpenseData(self) //id, name, payer, totalAmount
        for user in owers[0..<owerCount] {
            amountOwed[user] = autosplit
            amountPaid[user] = 0.0
            ModelManager.getInstance().addOwedPaidData(self, userInfo: user) //owers, amountOwed, //amountPaid
            print("how much does each owe? : \(amountOwed[user]!)")
        }
    }
    
    func getAmountOwed(user: User) throws -> Double { // Returns -1 if user is not involved
        /*
        var userOwes = 0.0
        do {
            try userOwes = ModelManager.getInstance().getAmountOwedForUserOneExpense(self, userInfo: user)
        }
        catch {
            
        }
        */
        
        //does not query because no change -- already stored locally
        guard let val = amountOwed[user] else {
            throw ExpenseError.userNotInvolved
        }
        print("\(val)")

        return val
    }
    
    func getAmountPaid(user: User) throws -> Double {
        guard let val = amountPaid[user] else {
            throw ExpenseError.userNotInvolved
        }
        return val
    }
    
    func getBalance(user: User) -> Double { //Same as getAmountOwed-getAmountPaid
        
        return amountOwed[user]!-amountPaid[user]!;
        
    }
    
    
}





