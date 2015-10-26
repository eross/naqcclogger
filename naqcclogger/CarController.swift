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
        newObj.setValue(points, forKey:"points")
        
        let multiplier = NSNumber(float: 1.0)
        newObj.setValue(multiplier, forKey:"multiplier")
        
        let band = NSNumber(integer: 20)
        newObj.setValue(band, forKey: "band")
        
        print("set points")
        return newObj
    }
    
}
