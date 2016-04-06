//
//  CharityCell.swift
//  charity-ios-app1.0
//
//  Created by Agnieszka Gancarczyk on 01/05/2015.
//  Copyright (c) 2015 WIT. All rights reserved.
//

import UIKit

class CharityCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var officeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
