//
//  ViewController.swift
//  naqcclogger
//
//  Created by Eric Ross on 9/26/15.
//  Copyright © 2015 Eric Ross. All rights reserved.
//

import Cocoa


class ViewController: NSViewController{

    dynamic var members: [Member] = [Member(id: 42, name: "Tom", qth: "Springfield")]
    
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
            let csvfile = "mac_naqcc_mems.csv"
            let path = file.path as String!
            let dir = NSString(string: path).stringByDeletingLastPathComponent
            
            let task = NSTask()
            let output = NSPipe()
            task.standardOutput = output
            
            task.launchPath = "/usr/bin/unzip"
            //TBD:  check for existence of old file and abort if it exists.
            task.arguments = ["-od\(dir)",path, csvfile]
            task.launch()
            
            let fileHandle = output.fileHandleForReading
            let data = fileHandle.readDataToEndOfFile()
            
            // TBD:  setup timer to kill if it hangs
            task.waitUntilExit()
            let status = task.terminationStatus
            let datastr = NSString(data: data, encoding: NSUTF8StringEncoding)
            if status != 0 {
                print("Error: status = \(status)")
                if let datastr = datastr {
                    NSLog(datastr as String)
                }
                return nil
            } else {
                return "\(dir)/\(csvfile)"
            }
        } else {
            return nil
        }
    }
    
    func parseFile(f: String) -> Void {
        do {
            var lines: String
            var members:[Member] = []
            try  lines = String(contentsOfFile: f, encoding: NSUTF8StringEncoding)
            for l in lines.componentsSeparatedByString("\n"){
                let fields = l.componentsSeparatedByString(",")
                let id:Int? = Int(fields[0])
              
            
                if let id = id {
                    let id32:Int32 = Int32(id)
                    let m = Member(id: id32, name: fields[1], qth: fields[2])
                    members.append(m)
                }
            }
            self.members = members
            
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func updatedb(urlstr: String){
        //let urlstr = "http://www.naqcc.info/mac_naqcc_mems.zip"
        let url = NSURL(string: urlstr)!
        
        let task = NSURLSession.sharedSession().downloadTaskWithURL(url) { (data, response, error) -> Void in
            
            if let err = error{
                self.alert(err.localizedDescription+":  "+urlstr)
            } else {
                if let csvfile = self.unpackdb(data){
                    NSLog("\(csvfile) has been retrieved")
                    self.parseFile(csvfile)
                    print("members contains \(self.members.count) items")
                    
                } else {
                    self.alert("Could not download database for NAQCC at\n\(urlstr).\nFile missing or bad format.")
                }
                
            }
        }
        task.resume()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updatedb("http://www.kb7td.com/mac_naqcc_mems.zip")
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
        
    

 
}

