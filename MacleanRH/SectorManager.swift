//
//  SectorManager.swift
//  MacleanRH
//
//  Created by iem on 04/06/2015.
//  Copyright (c) 2015 iem. All rights reserved.
//

import Foundation
import CoreData

class SectorManager
{
    lazy var coreData:CoreDataManager? = CoreDataManager.SharedManager
    
    /*var contextObject:NSManagedObjectContext? {
        get {
            if let context = coreData?.managedObjectContext {
                return context
            }
            return nil
        }
    }
    
    class var SharedManager: SectorManager {
        struct Singleton {
            static let instance = SectorManager()
        }
        
        Singleton.instance.coreData = CoreDataManager.SharedManager
        return Singleton.instance
    }
    
    func createSector(titre: String,workLibelle: String,workDescription: String,date: NSDate) -> Sector {
        
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
    }*/
}
