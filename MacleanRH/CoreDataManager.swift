//
//  CoreDataManager.swift
//  MacleanRH
//
//  Created by iem on 03/06/2015.
//  Copyright (c) 2015 iem. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let managedObjectContext: NSManagedObjectContext
    
    let persistentStoreCoordinator: NSPersistentStoreCoordinator
    
    let managedObjectModel: NSManagedObjectModel
    
    class var SharedManager: CoreDataManager {
        
        struct Singleton {
            
            static var instance = CoreDataManager()
        }
        
        return Singleton.instance
        
    }
    
    init() {
        
        let modelURL = NSBundle.mainBundle().URLForResource(Constants.DATABASE_NAME, withExtension: "momd")!
        
        let persistentStore: NSPersistentStore?
        
        managedObjectModel = NSManagedObjectModel(contentsOfURL: modelURL)!
        
        persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        managedObjectContext = NSManagedObjectContext()
        
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        
        let documentURL = self.applicationDocumentDirectory()
        
        let storeURL = documentURL.URLByAppendingPathComponent(Constants.DATABASE_FILE)
        
        let options = [NSMigratePersistentStoresAutomaticallyOption : true]
        
        
        
        var error:NSError? = nil
        
        persistentStore = persistentStoreCoordinator.addPersistentStoreWithType(NSSQLiteStoreType,
            configuration: nil,
            URL: storeURL,
            options: options,
            error: &error)
        
        if persistentStore == nil {
            
            println("Error adding persistence store: \(error)")
            
            abort()
            
        }
        
    }
    
    func applicationDocumentDirectory() -> NSURL {
        
        let fileManager = NSFileManager.defaultManager()
        
        let urls = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask) as! [NSURL]
        
        return urls[0]
        
    }
    
    func saveContext() {
        
        var error: NSError? = nil
        
        if managedObjectContext.hasChanges && !managedObjectContext.save(&error) {
            
            println("Failed to save context \(error), \(error?.userInfo)")
            
        }
    }
}