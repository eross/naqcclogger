//
//  Member.swift
//  naqcclogger
//
//  Created by Eric Ross on 9/27/15.
//  Copyright © 2015 Eric Ross. All rights reserved.
//

import Foundation

class Member: NSObject {
    var id: Int32 = 42
    var firstname: String = "Er"
    var qth: String = "sss"
    
    init(id: Int32, firstname: String, qth: String)
    {
        self.id = id
        self.firstname = firstname
        self.qth = qth
        
    }

}