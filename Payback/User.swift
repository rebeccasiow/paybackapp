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
            print("inside expense for loop")
            /*if expense.getAmountOwed(self) != -1 {
                print("inside expense != 1")*/
                total += expense.getAmountOwed(self)
            //}
        }
        return total
    }
    
    func addAsBuyer(expense: Expense){
        self.expensesWhereIsBuyer.append(expense)
    }
    
    func addAsOwer(expense: Expense){
        self.expensesWhereIsOwer.append(expense)
    }
    
    
    
    }
}
    func ==(left: User, right: User) -> Bool {
    return left.id == right.id
}
