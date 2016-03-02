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
    var owers:[User]
    var amountOwed:[User : Double]
    var amountPaid:[User : Double]
    
    init(id:Int, name:String, payer:User, totalAmount:Double, owers:[User], amountOwed:[User : Double],amountPaid:[User : Double]) {
        self.id = id
        self.name = name
        self.payer = payer
        self.totalAmount = totalAmount
        self.owers = owers
        self.amountOwed = amountOwed
        self.amountPaid = amountPaid

    }
    
    init(id:Int, name:String, payer:User, totalAmount:Double, owers:[User]) {
        
        self.id = id
        self.name = name
        self.payer = payer
        self.totalAmount = totalAmount
        self.owers = owers
        let owerCount = owers.count
        let autosplit = totalAmount/Double(owerCount)
        amountOwed = [User : Double]()
        amountPaid = [User : Double]()
        for user in owers[1..<owerCount] {
            amountOwed[user] = autosplit
            amountPaid[user] = 0.0
        }
        
    }
    
    
    func getAmountOwed(user: User) -> Double { // Returns -1 if user is not involved
        if let val = amountOwed[user] {
            return val
        }
        else {
            return -1;
        }        
    }
    func getAmountPaid(user: User) -> Double {
        if let val = amountPaid[user] {
            return val
        }
        else {
            return -1;
        }
        
    }
    func getBalance(user: User) -> Double { //Same as getAmountOwed-getAmountPaid
        
        return amountOwed[user]!-amountPaid[user]!;
        
    }
}





