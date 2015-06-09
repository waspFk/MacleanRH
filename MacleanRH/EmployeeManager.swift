//
//  EmployeeManager.swift
//  MacleanRH
//
//  Created by iem on 04/06/2015.
//  Copyright (c) 2015 iem. All rights reserved.
//

import Foundation
import CoreData

class EmployeeManager {
    lazy var coreData:CoreDataManager? = CoreDataManager.SharedManager
    
    var contextObject:NSManagedObjectContext? {
        get {
            if let context = coreData?.managedObjectContext {
                return context
            }
            return nil
        }
    }
    
    class var SharedManager: EmployeeManager {
        struct Singleton {
            static let instance = EmployeeManager()
        }
        
        Singleton.instance.coreData = CoreDataManager.SharedManager
        return Singleton.instance
    }
    
    private func fetchEmployees(predicate : NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> [Employee]? {
        let fetchRequest = NSFetchRequest(entityName: "Employee")
        
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        
        var error: NSError? = nil
        
        let results = contextObject!.executeFetchRequest(fetchRequest, error: &error) as! [Employee]
        
        if results.count > 0 {
            return results
        }
        
        if error != nil {
            println(" Could not fetch data : \(error), \(error?.description) ")
        }
        
        return nil
    }
    
    private func fetchEmployee(predicate : NSPredicate) -> Employee? {
        if let employees = fetchEmployees(predicate, sortDescriptors: nil) {
            return employees[0]
        }
        
        return nil
    }
    
    func searchEmployeesWithFirstName(name: String) -> [Employee] {
        var employees = [Employee]()
        
        let predicate = NSPredicate(format: "firstName = %@", name)
        let sortDescriptors = [NSSortDescriptor(key: "lastName", ascending: true)]
        
        if let results = fetchEmployees(predicate, sortDescriptors: sortDescriptors) {
            employees = results
        }
        
        return employees
    }
    
    func searchEmployeesWithLastName(name: String) -> [Employee] {
        var employees = [Employee]()
        
        let predicate = NSPredicate(format: "lastName = %@", name)
        let sortDescriptors = [NSSortDescriptor(key: "lastName", ascending: true)]
        
        if let results = fetchEmployees(predicate, sortDescriptors: sortDescriptors) {
            employees = results
        }
        
        return employees
    }
    
    func searchEmployeeWithMail(mail: String) -> Employee? {
        let predicate = NSPredicate(format: "mail = %@", mail)
        if let candidate = fetchEmployee(predicate) {
            return candidate
        }
        
        return nil
    }
    
    func getAllEmployees(sortField: String?) -> [Employee] {
        var employees = [Employee]()
        
        var sortDescriptors = [NSSortDescriptor]()
        if let fields = sortField {
            sortDescriptors = [NSSortDescriptor(key: fields, ascending: true)]
        } else {
            sortDescriptors = [NSSortDescriptor(key: "lastName", ascending: true)]
        }
        
        if let results = fetchEmployees(nil, sortDescriptors: sortDescriptors) {
            employees = results
        }
        
        return employees
    }
    
    func createEmployee(sap: String, lastname: String, firstname: String, mail: String, contract: Contract) -> Employee? {
        if searchEmployeeWithMail(mail) == nil {
            let entity = NSEntityDescription.entityForName("Employee", inManagedObjectContext: contextObject!)
            
            let employee = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: contextObject) as! Employee
            employee.numeroSAP = sap
            employee.firstName = firstname
            employee.lastName = lastname
            employee.mail = mail
            employee.contract = contract
            
            var error: NSError? = nil
            contextObject!.save(&error)
            
            if error != nil {
                println(" Could not save context : \(error), \(error?.description) ")
            }
            
            return employee
        }
        
        return nil
    }
    
    func deleteEmployee(employee: Employee?) {
        if let employeeValid = employee {
            contextObject?.delete(employeeValid)
            contextObject?.save(nil)
        }
    }
}

