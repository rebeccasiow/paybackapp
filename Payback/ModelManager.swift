//
//  ModelManager.swift
//  Payback
//
//  Created by Kelly Stathis on 3/2/16.
//  Copyright © 2016 Kelly Stathis. All rights reserved.
//

import UIKit

let sharedInstance = ModelManager()

class ModelManager: NSObject {
    
    var database:FMDatabase? = nil
    
    enum DatabaseError: ErrorType {
        case moreThanOneAmountOwedPerUserAndExpense
    }
    
    // This code is called at most once
    class func getInstance() -> ModelManager
    {
        if(sharedInstance.database == nil)
        {
            sharedInstance.database = FMDatabase(path: Utility.getPath("payback.sqlite"))
        }
        return sharedInstance
    }
    
    func addUserData(userInfo: User) -> Bool {
        sharedInstance.database!.open()
        let isInserted = sharedInstance.database!.executeUpdate("INSERT INTO users (id, userName) VALUES (NULL, ?)", withArgumentsInArray: [userInfo.name])
        sharedInstance.database!.close()
        return isInserted
    }
    
    func updateUserData(userInfo: User, id: Int) -> Bool {
        sharedInstance.database!.open()
        let isUpdated = sharedInstance.database!.executeUpdate("UPDATE users SET userName=? WHERE id=?", withArgumentsInArray: [userInfo.name, id])
        sharedInstance.database!.close()
        return isUpdated
    }
    
    //FIXME: To delete user, will also need to delete dependencies in other tables via foreign keys
    func deleteUserData(userInfo: User) -> Bool {
        sharedInstance.database!.open()
        let isDeleted = sharedInstance.database!.executeUpdate("DELETE FROM users WHERE userName=?", withArgumentsInArray: [userInfo.name])
        sharedInstance.database!.close()
        return isDeleted
    }
    
    func addExpenseData(expenseInfo: Expense) -> Bool {
        sharedInstance.database!.open()
        let isInserted = sharedInstance.database!.executeUpdate("INSERT INTO expenses (id, expenseName, buyerID, total) VALUES (NULL, ?, ?, ?)", withArgumentsInArray: [expenseInfo.name, expenseInfo.payer.id, expenseInfo.totalAmount])
        sharedInstance.database!.close()
        return isInserted
    }
    
    func updateExpenseData(expenseInfo: Expense, id: Int) -> Bool {
        sharedInstance.database!.open()
        let isUpdated = sharedInstance.database!.executeUpdate("UPDATE expenses SET expenseName=?, buyerID=?, total=? WHERE id=?", withArgumentsInArray: [expenseInfo.name, expenseInfo.payer.id, expenseInfo.totalAmount, id])
        sharedInstance.database!.close()
        return isUpdated
    }
    
    //FIXME: To delete expense, will also need to delete dependencies in other tables (owed_and_paid) via foreign keys
    func deleteExpenseData(expenseInfo: Expense) -> Bool {
        sharedInstance.database!.open()
        let isDeleted = sharedInstance.database!.executeUpdate("DELETE FROM expenses WHERE id=?", withArgumentsInArray: [expenseInfo.id])
        sharedInstance.database!.close()
        return isDeleted
    }


    func addOwedPaidData(expenseInfo: Expense, userInfo: User) -> Bool {
        sharedInstance.database!.open()
        let isInserted = sharedInstance.database!.executeUpdate("INSERT INTO owed_and_paid (id, expenseID, owerID, amountOwed, amountPaid) VALUES (NULL, ?, ?, ?, ?)", withArgumentsInArray: [expenseInfo.id, userInfo.id, expenseInfo.amountOwed[userInfo]!, expenseInfo.amountPaid[userInfo]!])
        sharedInstance.database!.close()
        return isInserted
    }
    
    func updateOwedPaidData(expenseInfo: Expense, userInfo: User) -> Bool {
        sharedInstance.database!.open()
        let isUpdated = sharedInstance.database!.executeUpdate("UPDATE owed_and_paid SET amountOwed=?, amountPaid=? WHERE expenseID=? AND owerID=?", withArgumentsInArray: [expenseInfo.amountOwed[userInfo]!, expenseInfo.amountPaid[userInfo]!, expenseInfo.id, userInfo.id])
        sharedInstance.database!.close()
        return isUpdated
    }
    
    func deleteOwedPaidData(expenseInfo: Expense, userInfo: User) -> Bool {
        sharedInstance.database!.open()
        let isDeleted = sharedInstance.database!.executeUpdate("DELETE FROM owed_and_paid WHERE expenseID=? AND owerID=?", withArgumentsInArray: [expenseInfo.id, userInfo.id])
        sharedInstance.database!.close()
        return isDeleted
    }
    
    /*
    func getAmountOwedForUserOneExpense(expenseInfo: Expense, userInfo: User) throws -> Double {
        sharedInstance.database!.open()
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * from owed_and_paid WHERE expenseID=? AND owerID=?", withArgumentsInArray: [expenseInfo.id, userInfo.id])
        var amountOwedArray:[Double] = []
        if (resultSet != nil) {
            while resultSet.next() {
                let amountOwed:Double = Double(resultSet.stringForColumn("amountOwed"))!
                amountOwedArray.append(amountOwed)
            }
        }
        if (amountOwedArray.count != 1) {
            throw DatabaseError.moreThanOneAmountOwedPerUserAndExpense
        }
        
        return Double(amountOwedArray[0])
    }
    */

    
    
    

    



}
