//
//  ListingEmployeeViewController.swift
//  MacleanRH
//
//  Created by iem on 05/06/2015.
//  Copyright (c) 2015 iem. All rights reserved.
//

import UIKit

class ListingEmployeeViewController: UIViewController {
    
    var employees = [Employee]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        employees = EmployeeManager.SharedManager.getAllEmployees("numeroSAP")
    }
    

}
