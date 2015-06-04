//
//  DegreeManager.swift
//  MacleanRH
//
//  Created by iem on 04/06/2015.
//  Copyright (c) 2015 iem. All rights reserved.
//

import Foundation
import CoreData

class DegreeManager {
    lazy var coreData:CoreDataManager? = CoreDataManager.SharedManager
    
    var contextObject:NSManagedObjectContext? {
        get {
            if let context = coreData?.managedObjectContext {
                return context
            }
            return nil
        }
    }
    
    class var SharedManager: DegreeManager {
        struct Singleton {
            static let instance = DegreeManager()
        }
        
        Singleton.instance.coreData = CoreDataManager.SharedManager
        return Singleton.instance
    }
    
    private func fetchDegrees(predicate : NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> [Degree]? {
        let fetchRequest = NSFetchRequest(entityName: "Degree")
        
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        
        var error: NSError? = nil
        
        let results = contextObject!.executeFetchRequest(fetchRequest, error: &error) as! [Degree]
        
        if results.count > 0 {
            return results
        }
        
        if error != nil {
            println(" Could not fetch data : \(error), \(error?.description) ")
        }
        
        return nil
    }
    
    private func fetchDegree(predicate : NSPredicate) -> Degree? {
        if let degrees = fetchDegrees(predicate, sortDescriptors: nil) {
            return degrees[0]
        }
        
        return nil
    }
    
    func searchDegreesForCandidate(candidate: Candidate) -> [Degree] {
        var degrees = [Degree]()
        
        let predicate = NSPredicate(format: "degree_candidate = %@", candidate)
        let sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        
        if let results = fetchDegrees(predicate, sortDescriptors: sortDescriptors) {
            return results
        }
        
        return degrees
    }
    
    func createDegree(titre: String, date: NSDate, candidate: Candidate) -> Degree? {
        let entity = NSEntityDescription.entityForName("Degree", inManagedObjectContext: contextObject!)
        
        let degree = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: contextObject) as! Degree
        
        degree.libelle = titre
        degree.date = date
        degree.degree_candidate = candidate
        
        var error: NSError? = nil
        contextObject!.save(&error)
        
        if error != nil {
            println(" Could not save context : \(error), \(error?.description) ")
        }
        
        return degree
    }
    
    func deleteDegree(degree: Degree?) {
        if let degreeValid = degree {
            contextObject?.delete(degree)
            contextObject?.save(nil)        }
    }
}