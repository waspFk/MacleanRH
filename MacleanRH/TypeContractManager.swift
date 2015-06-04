//
//  TypeContractManager.swift
//  MacleanRH
//
//  Created by iem on 04/06/2015.
//  Copyright (c) 2015 iem. All rights reserved.
//

import Foundation
import CoreData

enum TypeContractEnum : String {
    case CDI    = "CDI"
    case CDD    = "CDD"
    
    static let allValues = [CDI, CDD]
}

class TypeContractManager {
    lazy var coreData:CoreDataManager? = CoreDataManager.SharedManager
    
    var contextObject:NSManagedObjectContext? {
        get {
            if let context = coreData?.managedObjectContext {
                return context
            }
            return nil
        }
    }
    
    class var SharedManager: TypeContractManager {
        struct Singleton {
            static let instance = TypeContractManager()
        }
        
        Singleton.instance.coreData = CoreDataManager.SharedManager
        return Singleton.instance
    }
    
    
    
    private func fetchTypesContracts(predicate : NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> [TypeContract]? {
        let fetchRequest = NSFetchRequest(entityName: "TypeContract")
        
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        
        var error: NSError? = nil
        
        let results = contextObject!.executeFetchRequest(fetchRequest, error: &error) as! [TypeContract]
        
        if results.count > 0 {
            return results
        }
        
        if error != nil {
            println(" Could not fetch data : \(error), \(error?.description) ")
        }
        
        return nil
    }
    
    private func fetchTypeContract(predicate : NSPredicate) -> TypeContract? {
        if let types = fetchTypesContracts(predicate, sortDescriptors: nil) {
            return types[0]
        }
        
        return nil
    }
    
    
    private func createTypeContract(enumState : TypeContractEnum) -> TypeContract {
        let entity = NSEntityDescription.entityForName("TypeContract", inManagedObjectContext: contextObject!)
        
        let typeContract = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: contextObject) as! TypeContract
        
        typeContract.libelle = enumState.rawValue
        
        var error: NSError? = nil
        contextObject!.save(&error)
        
        if error != nil {
            println(" Could not save context : \(error), \(error?.description) ")
        }
        
        return typeContract
    }
    
    func determinateTypeContract(name: String?) -> TypeContract? {
        if let stringValue = name {
            let predicate = NSPredicate(format: "libelle = %@", stringValue)
            if let typeContract = fetchTypeContract(predicate) {
                return typeContract
            }
        }
        
        return nil
    }
    
    func getAllTypes () -> [TypeContract] {
        var types = [TypeContract]()
        
        let sortDescriptors = [NSSortDescriptor(key: "libelle", ascending: true)]
        
        if let results = fetchTypesContracts(nil, sortDescriptors: sortDescriptors) {
            types = results
        }
        
        return types
    }
    
    func getTypeContract(stateEnum : TypeContractEnum) -> TypeContract {
        var state:TypeContract
        
        let predicate = NSPredicate(format: "libelle = %@", stateEnum.rawValue)
        if let typeContract = fetchTypeContract(predicate) {
            state = typeContract
        } else {
            state = createTypeContract(stateEnum)
        }
        
        return state
    }
}