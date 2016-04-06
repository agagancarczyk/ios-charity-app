//
//  CharitiesViewController.swift
//  charity-ios-app1.0
//
//  Created by Agnieszka Gancarczyk on 01/05/2015.
//  Copyright (c) 2015 WIT. All rights reserved.
//

import UIKit

class CharitiesViewController: UITableViewController {

    var charities: [Charity] = CharitiesList().getAllCharities()
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charities.count
    }
   
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("CharityCell", forIndexPath: indexPath)
                as CharityCell
            
            let charity = charities[indexPath.row] as Charity
            cell.nameLabel.text = charity.name
            cell.officeLabel.text = charity.office
            return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            charities.removeAtIndex(indexPath.row)
            // Delete the row from the tableview
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "EditCharity" {
            let navigationController = segue.destinationViewController as UINavigationController
            let charityDetailsViewController = navigationController.viewControllers[0] as CharityDetailsViewController
            
            let cell = sender as UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let selectedCharityIndex = indexPath?.row
            
            if let index = selectedCharityIndex {
                let coffee = charities[index]
                charityDetailsViewController.charityToEdit = coffee
            }
        }
        
    }

    @IBAction func cancelToCharitiesViewController(segue:UIStoryboardSegue) {
        
    }
    
    @IBAction func saveCharityDetail(segue:UIStoryboardSegue) {
        let charityDetailsViewController = segue.sourceViewController as CharityDetailsViewController
        
        if let charityToEdit = charityDetailsViewController.charityToEdit {
            // get index of charityToEdit in charities array
            let charityToEditIndex = find(charities, charityToEdit)!
            
            // get indexPath of charityToEdit in tableView
            let indexPath = NSIndexPath(forRow: charityToEditIndex, inSection: 0)
            
            // reload that individual row
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
        else {
            //add the new charity to the charities array
            charities.append(charityDetailsViewController.charity)
            var urlStr = "http://lit-peak-4252.herokuapp.com/api/charities";
            var url = NSURL(string: urlStr)
            
            var name = charityDetailsViewController.charity.name
            var office = charityDetailsViewController.charity.office
            
            let json = "{\"name\":\"\(name)\", \"office\":\"\(office)\"}"
            
            let request = NSMutableURLRequest(URL: url!)
            request.HTTPMethod = "POST"
            
            
            let task = NSURLSession.sharedSession().uploadTaskWithRequest(request,
                fromData: json.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true))
            task.resume()

            
     
     
            //update the tableView
            let indexPath = NSIndexPath(forRow: charities.count-1, inSection: 0)
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
        
        //hide the detail view controller
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func deleteCharity(segue:UIStoryboardSegue) {
        let charityDetailsViewController = segue.sourceViewController as CharityDetailsViewController
        
        if let charityToEdit = charityDetailsViewController.charityToEdit {
            // get index of charityToEdit in charities array
            let charityToEditIndex = find(charities, charityToEdit)!
            
            // get indexPath of charityToEdit in tableView
            let indexPath = NSIndexPath(forRow: charityToEditIndex, inSection: 0)
            
            // delete charity from array
            charities.removeAtIndex(charityToEditIndex)
            
            // delete that individual row
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation:UITableViewRowAnimation.Fade)
            var id = charityToEdit.id
            var urlStr = "http://lit-peak-4252.herokuapp.com/api/charities/\(id)";
            var url = NSURL(string: urlStr)
            
            
            let request = NSMutableURLRequest(URL: url!)
            request.HTTPMethod = "DELETE"
            
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler: {
                (response:NSURLResponse!, data:NSData!, error:NSError!) -> Void in
                println()
            })

//            NSURLSession.sharedSession().uploadTaskWithRequest(request, fromFile: url!)
            
            
   
        }
        
        //hide the detail view controller
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    func getJSON(urlToRequest: String) -> NSData{
        return NSData(contentsOfURL: NSURL(string: urlToRequest)!)!
    }
    
    func parseJSON(inputData: NSData) -> NSArray{
        var error: NSError?
        var jsonDictionary: NSArray = NSJSONSerialization.JSONObjectWithData(inputData, options: nil, error: &error) as NSArray
        
        return jsonDictionary
    }
    
}
