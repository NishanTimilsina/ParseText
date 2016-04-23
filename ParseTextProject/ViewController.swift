//
//  ViewController.swift
//  ParseTextProject
//
//  Created by Nishan Timilsina on 4/18/16.
//  Copyright © 2016 Nishan Timilsina. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //var resumeDict:[String:NSMutableArray]=[:]
        var desArray=[String]()
       // let desArray:[String]=["Database"," SAP","DB2","UDP\n","IOS","Objective C","REST","Core Data","GCD","-","\t","$5","performance", "measures", "based", "on", "your", "workload\n-      ", "Check", "for", "automatic", "actions", "DB2", "has", "taken", "on", "your", "behalf\n-      ", "Ensure", "there", "is", "enough", "free", "memory\n-      ", "Manual", "Verification", "using", "Check", "Points", "on", "Table", "Spaces,", "Verify", "total", "storage", "on", "UNIX", "systems", "and", "Database", "snapshots\n-      ", "Verify", "parameters", "for", "Virtual", "Memory,", "Swap"]
        var resumeArray=[String]()
        var filteredDesArray=[String]()
        var count:Int=0;
        resumeArray=readDataFromFile("resume2")!
    
        desArray=readDataFromDes("description")!
        for filterText in desArray{
        filteredDesArray.append(removeSpecialCharsFromString(filterText))
        }
        print(resumeArray)
        //print(desArray)
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0))
            {
            for keys in resumeArray{
                if  filteredDesArray.contains(self.removeSpecialCharsFromString(keys)){
                    count++
                }
            }
            dispatch_async(dispatch_get_main_queue()) {
                print(count)
                print(filteredDesArray.count)
                self.displayLabel.text="\(count*100/filteredDesArray.count)% matched found!!!!"            }
        }
        
    }
    
    func removeSpecialCharsFromString(text: String) -> String {
        let okayChars : Set<Character> =
        Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890+-*=(),.:!_".characters)
        return String(text.characters.filter {okayChars.contains($0) })
    }
    func readDataFromFile(filename:String)->[String]?{
        var resArr=[String]()
        var keywords=[NSString]()
        var flag:Bool?
        keywords.append("Job Description:")
        keywords.append("Skills:")
        keywords.append("Requirement:")
        keywords.append("Responsibilities:")
        
        let url = NSBundle.mainBundle().URLForResource(filename, withExtension: "txt")!

        do {
            let text = try String( contentsOfURL: url, encoding: NSUTF8StringEncoding)
            for var i = 0; i<keywords.count; i++ {
            if(text.containsString(keywords[i] as String)){
            // Search for one string in another.
                    var result = text.rangeOfString(keywords[i] as String,
                        options: NSStringCompareOptions.LiteralSearch,
                        range: (text as String).startIndex..<(text as String).endIndex,
                        locale: nil)
                        for var j = i+1; j<keywords.count; j++ {
                                if(text.containsString(keywords[j] as String)){
                                    var innerResult = text.rangeOfString(keywords[j] as String,
                                        options: NSStringCompareOptions.LiteralSearch,
                                        range: (text as String).startIndex..<(text as String).endIndex,
                                        locale: nil)
                                    if let range = result {
                                    // Start of range of found string.
                                var start = range.startIndex
                                if let ran = innerResult{
                                    // Display string starting at first index.
                               resArr+=(text[start..<ran.startIndex]).componentsSeparatedByString(" ")
                                    break
                                        }
                        }
            
                    }
                    else{
                    flag=false
                    }
                    
                }//for loop end
                
                if flag==false  {
                if let range = result {

                var start = range.startIndex

                    resArr+=(text[start..<text.endIndex]).componentsSeparatedByString(" ")
                }

                }
            }

            }


        } catch let errOpening as NSError {
            print("Error!", errOpening)
            return nil
        }

        return resArr

    }
    
    func readDataFromDes(filename:String)->[String]?{
        let url = NSBundle.mainBundle().URLForResource(filename, withExtension: "txt")!
        //print("\(url)")
        
        do {
            let text = try NSString( contentsOfURL: url, encoding: NSUTF8StringEncoding)
            return text.componentsSeparatedByString(" ")
            
            
        } catch let errOpening as NSError {
            print("Error!", errOpening)
            return nil
        }
    }
    
    
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        // Dispose of any resources that can be recreated.
    }


}

