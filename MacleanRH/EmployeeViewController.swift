//
//  EmployeeViewController.swift
//  MacleanRH
//
//  Created by iem on 05/06/2015.
//  Copyright (c) 2015 iem. All rights reserved.
//

import UIKit

class EmployeeViewController: RootViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var employee: Employee!
    var employees: [Employee]!
    var degrees: [Degree]!
    var filteredTableEmployee: [Employee]!
    var searchActive : Bool = false
    
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldFirstName: UITextField!
    @IBOutlet weak var textFieldMail: UITextField!
    @IBOutlet weak var textFieldAddress: UITextField!
    @IBOutlet weak var textFieldTel: UITextField!
    @IBOutlet weak var textFieldGSM: UITextField!
    @IBOutlet weak var textFieldPoste: UITextField!
    @IBOutlet weak var textFieldBirthday: UITextField!
    
    @IBOutlet weak var labelDetailPoste: UILabel!
    
    @IBOutlet weak var tableViewDegree: UITableView!
    @IBOutlet weak var tableViewEmployee: UITableView!
    
    @IBOutlet weak var searchEmployee: UITableView!
    
    @IBAction func getWebViewWithViadeo(sender: AnyObject) {
        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("WebViewController") as! WebViewController
        viewController.url = "http://fr.viadeo.com/fr/"
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func getWebViewWithLinkedIn(sender: AnyObject) {
        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("WebViewController") as! WebViewController
        viewController.url = "https://www.linkedin.com/nhome/"
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func getWebViewWithXing(sender: AnyObject) {
        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("WebViewController") as! WebViewController
        viewController.url = "https://www.xing.com/fr"
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    func loadData(){
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.ShortStyle
        
        textFieldName.text = employee.lastName
        textFieldFirstName.text = employee.firstName
        textFieldMail.text = employee.mail
        textFieldAddress.text = employee.addressLocalisation
        textFieldTel.text = employee.tel
        textFieldGSM.text = employee.mobile
        textFieldPoste.text = employee.contract.workLibelle
        
 
        textFieldBirthday.text = formatter.stringFromDate(employee.birthDay!)
        
        
       
        labelDetailPoste.text = "Embauché le \(formatter.stringFromDate(employee.contract.dateStart!)) en \(employee.contract.typeContract!.libelle)"
        
        employees = EmployeeManager.SharedManager.getAllEmployees(nil)
        degrees = employee.contract.candidate!.getDegreesArray()
        
    }
    
    // MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        println("--numberOfRowsInSection -- CandidateViewController")
        if (searchActive == true)
        {
            return filteredTableEmployee.count
        }
        else if (tableView == self.tableViewEmployee) {
            return employees.count
            
        }
        else {
            return degrees.count
            
        }
        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if (searchActive == true) {
            let cell = tableViewEmployee.dequeueReusableCellWithIdentifier("EmployeeCell") as! EmployeeViewCell
            let curEmployee = filteredTableEmployee[indexPath.row]
            
            cell.avatar.frame = CGRectMake(0, 0, 100, 82)
            
            cell.firstName.text  = curEmployee.firstName
            cell.lastName.text   = curEmployee.lastName
            
            return cell
        }
        else if (tableView == self.tableViewEmployee) {
            let cell = tableViewEmployee.dequeueReusableCellWithIdentifier("EmployeeCell") as! EmployeeViewCell
            let curEmployee = employees[indexPath.row]
            
            cell.avatar.frame = CGRectMake(0, 0, 100, 82)
            
            cell.firstName.text  = curEmployee.firstName
            cell.lastName.text   = curEmployee.lastName
            
            return cell

        }
        else {
            var cell:UITableViewCell = self.tableViewDegree.dequeueReusableCellWithIdentifier("DegreeCell") as! UITableViewCell
            let degree = degrees[indexPath.row]
            
            cell.textLabel!.text = degree.libelle
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       
        if (tableView == tableViewEmployee) {
            employee = self.employees[indexPath.row]
            loadData()
            tableViewDegree.reloadData()
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
        self.tableViewEmployee.reloadData()
    }
    
    
    @IBAction func navRecruitment(sender: AnyObject) {
        println("test")
    }

    
    
    
    
}
