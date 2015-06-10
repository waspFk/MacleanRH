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
    @IBOutlet weak var typeContract: UISegmentedControl!
    var filterLastName = 0
    var filterFirstName = 0
    
    
    var employeeManager = EmployeeManager.SharedManager
    var employees : [Employee] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        employees = employeeManager.getAllEmployees(nil)
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
    
    @IBAction func SortListByLastName(sender: AnyObject) {
        if(self.filterLastName == 0){
            self.employees.sort(){ $0.lastName < $1.lastName }
            self.filterLastName = 1
        }else{
            self.employees.sort() { $0.lastName > $1.lastName }
            self.filterLastName = 0
        }
        self.tableEmployees.reloadData(); // notify the table view the data has changed
    }
    
    @IBAction func SortListByFirstName(sender: AnyObject) {
        if(self.filterFirstName == 0){
            self.employees.sort(){ $0.firstName < $1.firstName }
            self.filterFirstName = 1
        }else{
            self.employees.sort() { $0.firstName > $1.firstName }
            self.filterFirstName = 0
        }
        self.tableEmployees.reloadData(); // notify the table view the data has changed
    }
    /*
    @IBAction func SortListByContrat(sender: UISegmentedControl) {
        switch typeContract.selectedSegmentIndex
        {
        case 0:
            employees = employeeManager.getAllEmployees(nil)
        case 1:
            employees = employeeManager.getAllEmployees("CDI")
        case 1:
            employees = employeeManager.getAllEmployees("CDD")
        default:
            break; 
        }
        
        self.tableEmployees.reloadData(); // notify the table view the data has changed
    }
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "detailEmployee" {
            if let destination = segue.destinationViewController as? EmployeeViewController {
                if let index = tableEmployees.indexPathForSelectedRow()?.row {
                    destination.employee = employees[index]
                    destination.employees = employees
                }
            }
        }
    }
    
}
