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
    
    init() {
        
    }
    
    // Sum all the expenses in expensesWhereIsOwer where user is relevant
    func getAmountOwedTo(user: User) -> Double {
        
    }
    
    
    
}

func ==(left: User, right: User) -> Bool {
    return left.id == right.id
}