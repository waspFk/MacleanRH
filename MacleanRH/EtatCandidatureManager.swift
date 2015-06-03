//
//  EtatCandidatureManager.swift
//  MacleanRH
//
//  Created by iem on 03/06/2015.
//  Copyright (c) 2015 iem. All rights reserved.
//

import Foundation
import CoreData

class EtatCandidatureManager
{
    // let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    lazy var coreData:CoreDataManager? = CoreDataManager.SharedManager
    
    var contextObject:NSManagedObjectContext? {
        get {
            if let context = coreData?.managedObjectContext {
                return context
            }
            return nil
        }
    }
    
    
    class var SharedManager: EtatCandidatureManager {
        struct Singleton {
            static let instance = EtatCandidatureManager()
        }
        
        Singleton.instance.coreData = CoreDataManager.SharedManager
        return Singleton.instance
    }
    
    
    func createStateWithName(name : String?) -> EtatCandidature? {
        if let nameValue = name {
            let entity = NSEntityDescription.entityForName("EtatCandidature", inManagedObjectContext: contextObject!)
            
            let stateCandidature = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: contextObject)as! EtatCandidature
            
            stateCandidature.libelle = nameValue
            
            var error: NSError? = nil
            contextObject!.save(&error)
            
            if error != nil {
                println(" Could not save context : \(error), \(error?.description) ")
            }
            
            return stateCandidature
        }
        
        return nil
    }
    
    func fetchLocations(predicate : NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> [EtatCandidature]? {
        let fetchRequest = NSFetchRequest(entityName: "EtatCandidature")
        
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        
        var error: NSError? = nil
        
        let results = contextObject!.executeFetchRequest(fetchRequest, error: &error) as! [EtatCandidature]
        
        if results.count > 0 {
            return results
        }
        
        if error != nil {
            println(" Could not fetch data : \(error), \(error?.description) ")
        }
        
        return nil
    }
    
    func getState () -> [EtatCandidature] {
        var locations = [EtatCandidature]()
        
        let sortDescriptors = [NSSortDescriptor(key: "libelle", ascending: true)]
        
        if let results = fetchLocations(nil, sortDescriptors: sortDescriptors) {
            locations = results
        }
        
        return locations
    }

    
    
}
