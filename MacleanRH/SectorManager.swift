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
    
    var contextObject:NSManagedObjectContext? {
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
    
    func createSector(libelle: String) -> Sector {
        
        let entity = NSEntityDescription.entityForName("Sector", inManagedObjectContext: contextObject!)
        
        let sector = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: contextObject)as! Sector
        
        sector.libelle = libelle
        
        var error: NSError? = nil
        contextObject!.save(&error)
        
        if error != nil {
            println(" Could not save context : \(error), \(error?.description) ")
        }
        
        return sector
    }
    
    private func fetchSectors(predicate : NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> [Sector]? {
        let fetchRequest = NSFetchRequest(entityName: "Sector")
        
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        
        var error: NSError? = nil
        
        let results = contextObject!.executeFetchRequest(fetchRequest, error: &error) as! [Sector]
        
        if results.count > 0 {
            return results
        }
        
        if error != nil {
            println(" Could not fetch data : \(error), \(error?.description) ")
        }
        
        return nil
    }
    
    func fetchSector(predicate : NSPredicate) -> Sector? {
        
        if let sector = fetchSectors(predicate, sortDescriptors: nil) {
            return sector[0]
        }
        
        return nil
    }
    
    func searchRecruitment(titre: String) -> Sector?
    {
        let predicate = NSPredicate(format: "libelle = %@", titre)
        return fetchSector(predicate)
    }
    
    func getAllSectors (sortField: String?) -> [Sector] {
        var sector = [Sector]()
        
        var sortDescriptors = [NSSortDescriptor]() //= [NSSortDescriptor(key: "titre", ascending: true)]
        
        if let field = sortField {
            sortDescriptors = [NSSortDescriptor(key: field, ascending: true)]
        }
        else
        {
            sortDescriptors = [NSSortDescriptor(key: "titre", ascending: true)]
        }
        
        
        if let results = fetchSectors(nil, sortDescriptors: sortDescriptors) {
            sector = results
        }
        
        return sector
    }
    
    func deleteSector(sector: Sector?) {
        if let sectorObject = sector {
            contextObject!.deleteObject(sectorObject)
            contextObject!.save(nil)
        }
    }
}
