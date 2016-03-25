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
        if searchQuery.isEmpty || containsLetters(searchQuery){
            return
        }
        
        performSearch(searchQuery)
        
    }
    
    func performSearch(query: String) {
        let url = NSURL(string: "http://bankoleadebajo.com:8080/max-alcohol-to-price?price=\(query)")
        
        let request = NSMutableURLRequest(URL: url!)
        let session = NSURLSession.sharedSession()
        
        request.HTTPMethod = "GET"
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        let _: NSError?
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var resultJSON:NSArray?
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, err -> Void in
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            
            resultJSON = self.nsdataToJSON(data!)
            
            print(resultJSON)
            
            self.saveData(resultJSON)
        })
        
        
        task.resume()
        
    }
    
    //Save the data received to an array
    func saveData(results:NSArray?){
        var drinks = [Drink]()
        for var i = 0; i < results?.count; i++ {
            drinks.append((Drink(info: (results![i] as! NSDictionary)))!)
        }
    }
    
    // Convert from NSData to json object
    func nsdataToJSON(data: NSData) -> NSArray? {
        var json:AnyObject?
        do {
            json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
        } catch {
            print(error)
        }
        return (json as! NSArray)
    }
    
    //return true if a string contains letters
    func containsLetters(input: String) -> Bool {
        for chr in input.characters {
            if ((chr >= "a" && chr <= "z") || (chr >= "A" && chr <= "Z")) {
                return true
            }
        }
        return false
    }
}

