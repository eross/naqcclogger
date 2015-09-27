//
//  ViewController.swift
//  naqcclogger
//
//  Created by Eric Ross on 9/26/15.
//  Copyright © 2015 Eric Ross. All rights reserved.
//

import Cocoa


class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string: "http://www.naqcc.info/mac_naqcc_mems.zip")!
        
        let task = NSURLSession.sharedSession().downloadTaskWithURL(url) { (data, response, error) -> Void in
        
            if let file = data as NSURL!{
                let path = file.path as String!
            
                let fm = NSFileManager.defaultManager()
                if fm.fileExistsAtPath(path) {
                    do {
                        
                        try fm.moveItemAtPath(path, toPath: "/Users/ericr/Desktop/naqcc.zip")
                    } catch let error as NSError{
                        dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                            let alert = NSAlert()
                            alert.messageText = "Error downloading database"
                            alert.informativeText = error.localizedDescription
                            alert.addButtonWithTitle("Ok")
                            alert.runModal()
                        })
                                            }
                }
            }
        }
        task.resume()
        //print(NSTemporaryDirectory())

        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

