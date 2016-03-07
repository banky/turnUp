//
//  ViewController.swift
//  turnup
//
//  Created by Bankole Adebajo on 2016-01-06.
//  Copyright © 2016 Banky. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    //MARK: Properties
    
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func searchButton(sender: AnyObject) {
        let searchQuery:String = searchTextField.text!
        
        //Don't do anything for blank search
        if searchQuery.isEmpty {
            return
        }
        
        performSearch(searchQuery)
        
    }
    
    func performSearch(query: String) {
        let url = NSURL(string: "https://www.google.com")
        
        let request = NSMutableURLRequest(URL: url!)
        let session = NSURLSession.sharedSession()
                
        request.HTTPMethod = "GET"
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        let _: NSError?
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, err -> Void in
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            
            print("Response: \(response)")
            let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("Body: \(strData)")
            
        })
        
        task.resume()
    }
}

