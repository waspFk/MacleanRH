//
//  ContractManager.swift
//  MacleanRH
//
//  Created by iem on 04/06/2015.
//  Copyright (c) 2015 iem. All rights reserved.
//

import Foundation
import CoreData

class ContractManager
{
    lazy var coreData:CoreDataManager? = CoreDataManager.SharedManager
    
    var contextObject:NSManagedObjectContext? {
        get {
            if let context = coreData?.managedObjectContext {
                return context
            }
            return nil
        }
    }
    
    class var SharedManager: ContractManager {
        struct Singleton {
            static let instance = ContractManager()
        }
        
        Singleton.instance.coreData = CoreDataManager.SharedManager
        return Singleton.instance
    }
    
    func createContract(libelle: String, salary: String, workLibelle: String, typeContract: TypeContract) -> Contract {
        
        let entity = NSEntityDescription.entityForName("Contract", inManagedObjectContext: contextObject!)
        
        let contract = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: contextObject)as! Contract
        
        contract.libelle = libelle
        contract.salary = salary
        contract.workLibelle = workLibelle
        contract.typeContract = typeContract
        
        var error: NSError? = nil
        contextObject!.save(&error)
        
        if error != nil {
            println(" Could not save context : \(error), \(error?.description) ")
        }
        
        return contract
    }
    
    private func fetchContracts(predicate : NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> [Contract]? {
        let fetchRequest = NSFetchRequest(entityName: "Contract")
        
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        
        var error: NSError? = nil
        
        let results = contextObject!.executeFetchRequest(fetchRequest, error: &error) as! [Contract]
        
        if results.count > 0 {
            return results
        }
        
        if error != nil {
            println(" Could not fetch data : \(error), \(error?.description) ")
        }
        
        return nil
    }
    
    func getAllContracts (sortField: String?) -> [Contract] {
        var contracts = [Contract]()
        
        var sortDescriptors = [NSSortDescriptor]() //= [NSSortDescriptor(key: "titre", ascending: true)]
        
        if let field = sortField {
            sortDescriptors = [NSSortDescriptor(key: field, ascending: true)]
        }
        else
        {
            sortDescriptors = [NSSortDescriptor(key: "libelle", ascending: true)]
        }
        
        
        if let results = fetchContracts(nil, sortDescriptors: sortDescriptors) {
            contracts = results
        }
        
        return contracts
    }
    
    func fetchContract(predicate : NSPredicate) -> Contract? {
        
        if let contract = fetchContracts(predicate, sortDescriptors: nil) {
            return contract[0]
        }
        
        return nil
    }
    
    func searchContract(key: String, data: String) -> Contract?
    {
        let predicate = NSPredicate(format: "\(key) = %@", data)
        return fetchContract(predicate)
    }
    
    func deleteContract(contract: Contract?) {
        if let contractObject = contract {
            contextObject!.deleteObject(contractObject)
            contextObject!.save(nil)
        }
    }

    
    
 
}