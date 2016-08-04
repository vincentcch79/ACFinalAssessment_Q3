//
//  ViewController.swift
//  ACFinalAssessment_Q3
//
//  Created by 張智涵 on 2016/8/4.
//  Copyright © 2016年 張智涵 Vincent Chang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func GETButton(sender: AnyObject) {
        
        let urlString = "https://httpbin.org/get"
        
        Alamofire.request(.GET, urlString, parameters: ["foo": "bar"])
            .responseJSON {
                response in
                
                if let data = response.result.value {
                    let json = JSON(data)
                    
                    let origin = json["origin"].stringValue
                    print(origin)
                    NSLog("Preparing for GET request to: \(origin)")
                    
                }
        }
    }

    @IBAction func POSTButton(sender: AnyObject) {
        let postUrl = "https://httpbin.org/post"
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
        let currentTime = dateFormatter.stringFromDate(NSDate())
        let parameters = ["time": "\(currentTime)"]
        
        
        Alamofire.request(.POST, postUrl, parameters: parameters).responseJSON {
            response in
            
            if let data = response.result.value {
                let content = JSON(data)
                let spendingTime = dateFormatter.dateFromString(String(content["form"]["time"]))
                let timeGap = NSString(format:"%.4f", -(spendingTime?.timeIntervalSinceNow)!)
                NSLog("花了\(timeGap)秒")
                
            }
            
            
        }
    }


}

