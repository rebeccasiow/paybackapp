//
//  UserInfo.swift
//  Payback
//
//  Created by Kelly Stathis on 3/2/16.
//  Copyright © 2016 Kelly Stathis. All rights reserved.
//

import UIKit

class UserInfo: NSObject {
    //var id: String = String() // Note: actually an integer
    var userName: String = String()
    
    init(name: String) {
        self.userName = name
    }

}
