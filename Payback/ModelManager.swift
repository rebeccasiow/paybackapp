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
    
    // This code is called at most once
    class func getInstance() -> ModelManager
    {
        if(sharedInstance.database == nil)
        {
            sharedInstance.database = FMDatabase(path: Utility.getPath("payback.sqlite"))
        }
        return sharedInstance
    }
    
    func addData(userInfo: UserInfo) -> Bool {
        print("in addData")
        sharedInstance.database!.open()
        print("database opened")
        let isInserted = sharedInstance.database!.executeUpdate("INSERT INTO users (id, userName) VALUES (NULL, ?)", withArgumentsInArray: [userInfo.userName])
        print("inserted")
        sharedInstance.database!.close()
        print("closed database, about to return isInserted")
        return isInserted
    }
    
    
/*
    
    func updateStudentData(studentInfo: StudentInfo) -> Bool {
        sharedInstance.database!.open()
        let isUpdated = sharedInstance.database!.executeUpdate("UPDATE student_info SET Name=?, Marks=? WHERE RollNo=?", withArgumentsInArray: [studentInfo.Name, studentInfo.Marks, studentInfo.RollNo])
        sharedInstance.database!.close()
        return isUpdated
    }
    
    func deleteStudentData(studentInfo: StudentInfo) -> Bool {
        sharedInstance.database!.open()
        let isDeleted = sharedInstance.database!.executeUpdate("DELETE FROM student_info WHERE RollNo=?", withArgumentsInArray: [studentInfo.RollNo])
        sharedInstance.database!.close()
        return isDeleted
    }
*/


}
