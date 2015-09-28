//
//  ViewController.swift
//  naqcclogger
//
//  Created by Eric Ross on 9/26/15.
//  Copyright © 2015 Eric Ross. All rights reserved.
//

import Cocoa


class ViewController: NSViewController {

    
    func alert(msg: String){
        dispatch_sync(dispatch_get_main_queue(), { () -> Void in
            let alert = NSAlert()
            alert.messageText = "Error downloading database"
            alert.informativeText = msg
            alert.addButtonWithTitle("Ok")
            alert.runModal()
        })

    }
    
    func unpackdb(file: NSURL?) -> String?
    {
        if let file = file as NSURL!{
            let path = file.path as String!
            let dir = NSString(string: path).stringByDeletingLastPathComponent
            
            let task = NSTask()
            task.launchPath = "/usr/bin/unzip"
            task.arguments = ["-fod\(dir)",path, "mac_naqcc_mems.csv"]
            task.launch()
            task.waitUntilExit()
            let status = task.terminationStatus
            
            if status != 0 {
                print("Error: status = \(status)")
                return nil
            } else {
                return "\(dir)/mac_naqcc_mems.csv"
            }
        }

        return "f"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlstr = "http://www.kb7td.com/mac_naqcc_mems.zip"
        //let urlstr = "http://www.naqcc.info/mac_naqcc_mems.zip"
        let url = NSURL(string: urlstr)!
        
        let task = NSURLSession.sharedSession().downloadTaskWithURL(url) { (data, response, error) -> Void in
        
            if let err = error{
                self.alert(err.localizedDescription+":  "+urlstr)
            } else {
                if let csvfile = self.unpackdb(data){
                    print(csvfile)
                } else {
                    self.alert("Could not download database for NAQCC at\n\(urlstr).\nFile missing or bad format.")
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

