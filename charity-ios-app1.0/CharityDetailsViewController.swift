//
//  CharityDetailsViewController.swift
//  charity-ios-app1.0
//
//  Created by Agnieszka Gancarczyk on 01/05/2015.
//  Copyright (c) 2015 WIT. All rights reserved.
//

import UIKit

class CharityDetailsViewController: UITableViewController {

    var charity:Charity!
    var office:String = "Dublin"
    
    var charityToEdit:Charity?
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var deleteButtonCell: UITableViewCell!

    
    required init(coder aDecoder: NSCoder) {
        //println("init CharityDetailsViewController")
        super.init(coder: aDecoder)
    }
    
    deinit {
        //println("deinit CharityDetailsViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(charityToEdit != nil){
            self.title = "Edit Charity"
            nameTextField.text = charityToEdit!.name
            office = charityToEdit!.office
        }
        else{
            office = "Cracov"
            deleteButtonCell.hidden = true
        }
        detailLabel.text = office
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            nameTextField.becomeFirstResponder()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SaveCharityDetail" {
            if (self.charityToEdit != nil){
                self.charityToEdit?.name = self.nameTextField.text
                self.charityToEdit?.office = office
                
            }
            else{
                charity = Charity(name: self.nameTextField.text, office: office, id: 0)
            }
        }
        if segue.identifier == "PickOffice" {
            let officePickerViewController = segue.destinationViewController as OfficePickerViewController
            officePickerViewController.selectedOffice = office
        }
    }
    
    @IBAction func selectedOffice(segue:UIStoryboardSegue) {
        let officePickerViewController = segue.sourceViewController as OfficePickerViewController
        if let selectedOffice = officePickerViewController.selectedOffice {
            detailLabel.text = selectedOffice
            office = selectedOffice
        }
    }
}
