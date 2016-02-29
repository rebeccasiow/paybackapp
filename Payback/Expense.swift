//
//  Expense.swift
//  Payback
//
//  Created by Kelly Stathis on 2/29/16.
//  Copyright © 2016 Kelly Stathis. All rights reserved.
//

import Foundation

class Expense {
    var id:Int
    var name:String
    var payer:User
    var totalAmount:Double
    var amountOwed:[User : Double]
    var amountPaid:[User : Double]
    
    init() {
        
    }
    
    
    func getAmountOwed(user: User) -> Double { // Returns -1 if user is not involved
        
    }
    func getAmountPaid(user: User) -> Double {
        
    }
    func getBalance(user: User) -> Double { //Same as getAmountOwed-getAmountPaid
        
    }
}





