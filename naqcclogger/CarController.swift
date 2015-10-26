//
//  CarController.swift
//  naqcclogger
//
//  Created by Eric Ross on 10/26/15.
//  Copyright © 2015 Eric Ross. All rights reserved.
//

import Cocoa

class CarController: NSArrayController {
    override func newObject() -> AnyObject {
        let newObj = super.newObject() as! NSObject
        let points = NSNumber(integer: 42)
        let multiplier = NSNumber(float: 1.0)
        newObj.setValue(points, forKey:"points")
        newObj.setValue(multiplier, forKey:"multiplier")
        print("set points")
        return newObj
    }
    
}
