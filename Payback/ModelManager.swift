//
//  ModelManager.swift
//  Payback
//
//  Created by Kelly Stathis on 3/2/16.
//  Copyright © 2016 Kelly Stathis. All rights reserved.
//

import UIKit

// FIX ME
class ModelManager: NSObject {
    
    static var database:Int
    
    override init() {
        
    }

    let sharedInstance = ModelManager()
    
    // This code is called at most once
    class func getInstance() -> ModelManager
    {
        if(sharedInstance.database == nil)
        {
            sharedInstance.database = FMDatabase(path: Utility.getPath("payback.sqlite"))
        }
        return sharedInstance
    }

}
