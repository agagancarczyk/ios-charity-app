//
//  Charity.swift
//  charity-ios-app1.0
//
//  Created by Agnieszka Gancarczyk on 01/05/2015.
//  Copyright (c) 2015 WIT. All rights reserved.
//

import Foundation
import UIKit

class Charity: Serializable {
    var name: String
    var office: String
    var id: Int
    
    init(name: String, office: String, id: Int) {
        self.name = name
        self.office = office
        self.id = id
        super.init()
    }
    
    init(json: NSDictionary){
        self.name = json["name"] as String
        self.office = json["office"] as String
        self.id = json["id"] as Int
    }
    
    
}