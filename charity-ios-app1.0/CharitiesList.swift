//
//  CharitiesList.swift
//  charity-ios-app1.0
//
//  Created by Agnieszka Gancarczyk on 10/05/2015.
//  Copyright (c) 2015 WIT. All rights reserved.
//

import Foundation

class CharitiesList{
    func getAllCharities() -> [Charity]{
        var allCharitiesJson = getJSON("http://lit-peak-4252.herokuapp.com/api/charities")
        var allCharities = parseJSON(allCharitiesJson)
        var charitiepTemp: [Charity] = []
        for obj : AnyObject in allCharities{
            var charityDict: NSDictionary = obj as NSDictionary
            var charity = Charity(json: charityDict)
            charitiepTemp.append(charity)
        }
        return charitiepTemp
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
