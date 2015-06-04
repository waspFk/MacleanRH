//
//  RecruitmentManager.swift
//  MacleanRH
//
//  Created by iem on 04/06/2015.
//  Copyright (c) 2015 iem. All rights reserved.
//

import Foundation
import CoreData

class RecruitmentManager
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
    
    class var SharedManager: RecruitmentManager {
        struct Singleton {
            static let instance = RecruitmentManager()
        }
        
        Singleton.instance.coreData = CoreDataManager.SharedManager
        return Singleton.instance
    }
    
    
    func createRecruitment(recruitment : Recruitment) -> Recruitment {
        
        let titre = recruitment.titre
        let workLibelle = recruitment.workLibelle
        let workDescription = recruitment.workDescription
        let date = recruitment.date
        
        
        let entity = NSEntityDescription.entityForName("Recruitment", inManagedObjectContext: contextObject!)
        
        let recruitmentReturn = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: contextObject)as! Recruitment
        
        recruitmentReturn.titre = titre
        recruitmentReturn.workLibelle = workLibelle
        recruitmentReturn.workDescription = workDescription
        recruitmentReturn.date = date
        
        var error: NSError? = nil
        contextObject!.save(&error)
        
        if error != nil {
            println(" Could not save context : \(error), \(error?.description) ")
        }
        
        return recruitmentReturn
    }
    
    private func fetchRecruitments(predicate : NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> [Recruitment]? {
        let fetchRequest = NSFetchRequest(entityName: "Recruitment")
        
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        
        var error: NSError? = nil
        
        let results = contextObject!.executeFetchRequest(fetchRequest, error: &error) as! [Recruitment]
        
        if results.count > 0 {
            return results
        }
        
        if error != nil {
            println(" Could not fetch data : \(error), \(error?.description) ")
        }
        
        return nil
    }
    
    func getAllRecruitments () -> [Recruitment] {
        var recruitment = [Recruitment]()
        
        let sortDescriptors = [NSSortDescriptor(key: "titre", ascending: true)]
        
        if let results = fetchRecruitments(nil, sortDescriptors: sortDescriptors) {
            recruitment = results
        }
        
        return recruitment
    }
}