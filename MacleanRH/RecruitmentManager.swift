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
    
    func createRecruitment(titre: String, workLibelle: String, workDescription: String,date: NSDate, sector: Sector) -> Recruitment? {
        
        if searchRecruitment(titre) == nil {
            let entity = NSEntityDescription.entityForName("Recruitment", inManagedObjectContext: contextObject!)
            
            let recruitmentReturn = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: contextObject)as! Recruitment
            
            recruitmentReturn.titre = titre
            recruitmentReturn.workLibelle = workLibelle
            recruitmentReturn.workDescription = workDescription
            recruitmentReturn.date = date
            recruitmentReturn.sector = sector
            
            var error: NSError? = nil
            contextObject!.save(&error)
            
            if error != nil {
                println("RecruitmentManager -- Could not save context : \(error)")
            }
            
            return recruitmentReturn
        }
        
        return nil
    }
    
    func fetchRecruitment(predicate : NSPredicate) -> Recruitment? {
        
        if let recruitment = fetchRecruitments(predicate, sortDescriptors: nil) {
            return recruitment[0]
        }
        
        return nil
    }
    
    func searchRecruitment(titre: String) -> Recruitment?
    {
       let predicate = NSPredicate(format: "titre = %@", titre)
        return fetchRecruitment(predicate)
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
            println("RecruitmentManager -- Could not fetch data : \(error)")
        }
        
        return nil
    }
    
    func getAllRecruitments (sortField: String?) -> [Recruitment] {
        var recruitment = [Recruitment]()
        
        var sortDescriptors = [NSSortDescriptor]() //= [NSSortDescriptor(key: "titre", ascending: true)]
        
        if let field = sortField {
            sortDescriptors = [NSSortDescriptor(key: field, ascending: true)]
        }
        else
        {
            sortDescriptors = [NSSortDescriptor(key: "titre", ascending: true)]
        }
        
        
        if let results = fetchRecruitments(nil, sortDescriptors: sortDescriptors) {
            recruitment = results
        }
        
        return recruitment
    }
    
    func deleteRecruitment(recruitment: Recruitment?) {
        if let recruitmentObject = recruitment {
            contextObject!.deleteObject(recruitmentObject)
            contextObject!.save(nil)
        }
    }
}