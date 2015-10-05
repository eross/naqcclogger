//
//  Member.swift
//  naqcclogger
//
//  Created by Eric Ross on 9/27/15.
//  Copyright © 2015 Eric Ross. All rights reserved.
//

import Foundation

class Member: NSObject {
    let id: Int32
    let name: String
    let qth: String
    
    init(id: Int32, firstname: String, qth: String)
    {
        self.id = id
        self.name = firstname
        self.qth = qth
        
    }

}