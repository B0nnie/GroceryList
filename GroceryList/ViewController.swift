//
//  ViewController.swift
//  GroceryList
//
//  Created by Ebony Nyenya on 3/23/16.
//  Copyright © 2016 Ebony Nyenya. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var txtFldEnterItem: UITextField!
  
    private var itemsArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtFldEnterItem.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        guard let list = NSUserDefaults.standardUserDefaults().objectForKey("groceryList") as? [String] else { return }
        
        itemsArray = list
        
        tableView.reloadData()
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = itemsArray[indexPath.row]
        cell.textLabel?.textColor = UIColor.whiteColor()
    
        // txtFldEnterItem.becomeFirstResponder()
        
        return cell
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        addItemToList()
        return false
    }
    
    func addItemToList(){
        
        if txtFldEnterItem.text == "" {
            let errorAlert = UIAlertController(title: "Error", message: "Please enter a grocery item", preferredStyle: .Alert)
            
            errorAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler : {(action) -> Void in
                
                self.dismissViewControllerAnimated(true, completion: nil)
                
            } ))
            
            self.presentViewController(errorAlert, animated: true, completion: nil)
            
        } else {
            
            addItemToArray(txtFldEnterItem.text!)
            
        }
        
    }
    
    func addItemToArray(item: String) {
        
        itemsArray.append(item)
        
        NSUserDefaults.standardUserDefaults().setObject(itemsArray, forKey: "groceryList")
        
        txtFldEnterItem.text = ""
        
        tableView.reloadData()
        
    }
    
    //deleting item
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            
            itemsArray.removeAtIndex(indexPath.row)
            NSUserDefaults.standardUserDefaults().setObject(itemsArray, forKey: "groceryList")
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
        
    }
    
    
}

