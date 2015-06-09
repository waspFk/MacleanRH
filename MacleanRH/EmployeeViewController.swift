//
//  EmployeeViewController.swift
//  MacleanRH
//
//  Created by iem on 05/06/2015.
//  Copyright (c) 2015 iem. All rights reserved.
//

import UIKit

class EmployeeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var employee : Employee!
    var employees : [Employee]!
    
    @IBOutlet weak var tableEmployees: UITableView!
    @IBOutlet weak var numSapEmployee: UITextField!
    @IBOutlet weak var photoEmployee: UIImageView!
    @IBOutlet weak var lastNameEmployee: UITextField!
    @IBOutlet weak var firstNameEmployee: UITextField!
    @IBOutlet weak var adresseEmployee: UITextField!
    @IBOutlet weak var mailEmployee: UITextField!
    @IBOutlet weak var phoneEmployee: UITextField!
    @IBOutlet weak var mobileEmployee: UITextField!
    @IBOutlet weak var secteurEmployee: UIPickerView!
    @IBOutlet weak var posteEmloyee: UIPickerView!
    @IBOutlet weak var contratEmployee: UISegmentedControl!
    @IBOutlet weak var beginDateContrat: UITextField!
    @IBOutlet weak var endDateContrat: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeEmployee()
        
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        employee = employees[indexPath.item]
        changeEmployee()
    }
    
    func changeEmployee() {
        numSapEmployee.text = employee.numeroSAP
        firstNameEmployee.text = employee.firstName
        lastNameEmployee.text = employee.lastName
        mailEmployee.text = employee.mail
    }
    
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
}
