//
//  User.swift
//  Payback
//
//  Created by Kelly Stathis on 2/29/16.
//  Copyright © 2016 Kelly Stathis. All rights reserved.
//

import Foundation

class User : Hashable {
    var id:Int
    var name: String
    var expensesWhereIsBuyer:[Expense]
    var expensesWhereIsOwer:[Expense]
    var hashValue: Int {
        get {
            return self.id
        }
    }
    
    init(id:Int, name: String) {
        self.id = id
        self.name = name
        self.expensesWhereIsBuyer = []
        self.expensesWhereIsOwer = []
    }

    
    // Sum all the expenses in expensesWhereIsOwer where user is relevant
    func getAmountOwedTo(user: User) -> Double {
        var total: Double = 0.0
        print("inside get amount owed")
        for expense : Expense in expensesWhereIsOwer{
            do {
                try total += expense.getAmountOwed(self)
            } catch ExpenseError.userNotInvolved {
                print("Error: User Not Involved in Transaction.")
            } catch{
                print("Error: General.")
            }
        }
        return total
    
    }
    
    func addAsBuyer(expense: Expense){
        print("inside add as buyer")
        self.expensesWhereIsBuyer.append(expense)
    }
    
    func addAsOwer(expense: Expense){
        print("inside add as ower")
        self.expensesWhereIsOwer.append(expense)
    }
    
    
    
}
    func ==(left: User, right: User) -> Bool {
    return left.id == right.id
}