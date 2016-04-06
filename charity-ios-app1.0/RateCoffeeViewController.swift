//
//  RateCoffeeViewController.swift
//  CoffeeMate
//
//  Created by Robert O'Connor on 06/02/2015.
//  Copyright (c) 2015 WIT. All rights reserved.
//

import UIKit

class RateCoffeeViewController: UIViewController {

    var coffeeToRate:Charity!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.coffeeToRate.name;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

  
    
}
