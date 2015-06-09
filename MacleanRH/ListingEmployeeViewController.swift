//
//  ListingEmployeeViewController.swift
//  MacleanRH
//
//  Created by iem on 05/06/2015.
//  Copyright (c) 2015 iem. All rights reserved.
//

import CoreData
import UIKit

class ListingEmployeeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableEmployees: UITableView!
    @IBOutlet weak var searchEmployee: UISearchBar!
    
    var employeeManager = EmployeeManager.SharedManager
    var employees = [Employee]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        employees = EmployeeManager.SharedManager.getAllEmployees(nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableEmployees.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! EmployeeViewCell
        
        let employee = employees[indexPath.row]
        
        cell.lastName.text = employee.lastName
        cell.firstName.text = employee.firstName
        
        if let picture = employee.photo {
            cell.avatar.image = UIImage(data: picture)
        }
        
        return cell
    }
}
