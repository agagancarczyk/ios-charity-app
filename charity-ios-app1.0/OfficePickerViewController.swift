//
//  OfficePickerViewController.swift
//  charity-ios-app1.0
//
//  Created by Agnieszka Gancarczyk on 01/05/2015.
//  Copyright (c) 2015 WIT. All rights reserved.
//

import UIKit

class OfficePickerViewController: UITableViewController {
    var selectedOffice:String? = nil
    var selectedOfficeIndex:Int? = nil
    
    var offices:[String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        offices = ["Cracov",
            "Dublin"]
        
        if let office = selectedOffice {
            selectedOfficeIndex = find(offices, office)!
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offices.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("OfficeCell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = offices[indexPath.row]
            
        if indexPath.row == selectedOfficeIndex {
            cell.accessoryType = .Checkmark
        }
        else {
            cell.accessoryType = .None
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        //Other row is selected - need to deselect it
        if let index = selectedOfficeIndex {
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0))
            cell?.accessoryType = .None
        }
        
        selectedOfficeIndex = indexPath.row
        selectedOffice = offices[indexPath.row]
        
        //update the checkmark for the current row
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = .Checkmark
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SaveSelectedOffice" {
            let cell = sender as UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            selectedOfficeIndex = indexPath?.row
            if let index = selectedOfficeIndex {
                selectedOffice = offices[index]
            }
        }
    }

}
