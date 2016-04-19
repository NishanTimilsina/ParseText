//
//  ViewController.swift
//  ParseTextProject
//
//  Created by Nishan Timilsina on 4/18/16.
//  Copyright © 2016 Nishan Timilsina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        var desArray=[String]()
        var resumeArray=[String]()
        var filteredDesArray=[String]()
        var count:Int=0;
        resumeArray=readDataFromFile("resume")!
        desArray=readDataFromFile("description")!
        for filterText in desArray{
        filteredDesArray.append(removeSpecialCharsFromString(filterText))
        }
        print(filteredDesArray)
        //print(desArray)
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0))
            {
            for keys in resumeArray{
                if  filteredDesArray.contains(self.removeSpecialCharsFromString(keys)){
                    count++
                }
            }
            dispatch_async(dispatch_get_main_queue()) {
                self.displayLabel.text="\(count*100/filteredDesArray.count)% matched found!!!!"            }
        }
        
    }
    
    func removeSpecialCharsFromString(text: String) -> String {
        let okayChars : Set<Character> =
        Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890+-*=(),.:!_".characters)
        return String(text.characters.filter {okayChars.contains($0) })
    }
    func readDataFromFile(filename:String)->[String]?{
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

