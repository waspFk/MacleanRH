//
//  ListingEmployeeViewController.swift
//  MacleanRH
//
//  Created by iem on 05/06/2015.
//  Copyright (c) 2015 iem. All rights reserved.
//

import CoreData
import UIKit

class ListingEmployeeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate {
    
    @IBOutlet weak var tableEmployees: UITableView!
    @IBOutlet weak var searchEmployee: UISearchBar!
    
    var filteredTableEmployee: [Employee]!
    
    var searchActive : Bool = false
    
    var employeeManager = EmployeeManager.SharedManager
    var employees = [Employee]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        employees = EmployeeManager.SharedManager.getAllEmployees(nil)
        println(employees.count)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchActive == true {
            return filteredTableEmployee.count
        }
        else
        {
            return employees.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if searchActive == true {
            let cell = self.tableEmployees.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! EmployeeViewCell
            
            let employee = filteredTableEmployee[indexPath.row]
            
            cell.lastName.text = employee.lastName
            cell.firstName.text = employee.firstName
            
            if let picture = employee.photo {
                cell.avatar.image = UIImage(data: picture)
            }
            
            return cell
        }
        else {
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "EmployeeViewSegue" {
            if let destination = segue.destinationViewController as? EmployeeViewController {
                if let index = tableEmployees.indexPathForSelectedRow()?.row {
                    destination.employee = employees[index]
                }
            }
        }
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchActive = true
        
        filteredTableEmployee = employees.filter({ (text) -> Bool in
            let tmpLastName: NSString = text.lastName
            let filterLastname = tmpLastName.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            
            let tmpFirstName: NSString = text.firstName
            let filterFirstName = tmpFirstName.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            
            return (filterLastname.location != NSNotFound) || (filterFirstName.location != NSNotFound)
        })
        if(filteredTableEmployee.count > 0){
            searchActive = true;
        } else {
            searchActive = false;
        }
        self.tableEmployees.reloadData()
    }


}
