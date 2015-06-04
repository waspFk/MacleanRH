//
//  CandidateManager.swift
//  MacleanRH
//
//  Created by iem on 04/06/2015.
//  Copyright (c) 2015 iem. All rights reserved.
//

import Foundation
import CoreData

class CandidateManager {
    lazy var coreData:CoreDataManager? = CoreDataManager.SharedManager
    
    var contextObject:NSManagedObjectContext? {
        get {
            if let context = coreData?.managedObjectContext {
                return context
            }
            return nil
        }
    }
    
    class var SharedManager: CandidateManager {
        struct Singleton {
            static let instance = CandidateManager()
        }
        
        Singleton.instance.coreData = CoreDataManager.SharedManager
        return Singleton.instance
    }
    
    private func fetchCandidates(predicate : NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> [Candidate]? {
        let fetchRequest = NSFetchRequest(entityName: "Candidate")
        
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        
        var error: NSError? = nil
        
        let results = contextObject!.executeFetchRequest(fetchRequest, error: &error) as! [Candidate]
        
        if results.count > 0 {
            return results
        }
        
        if error != nil {
            println(" Could not fetch data : \(error), \(error?.description) ")
        }
        
        return nil
    }
    
    private func fetchCandidate(predicate : NSPredicate) -> Candidate? {
        if let candidates = fetchCandidates(predicate, sortDescriptors: nil) {
            return candidates[0]
        }
        
        return nil
    }
    
    func searchCandidateWithFirstName(name: String) -> [Candidate] {
        var candidates = [Candidate]()
        
        let predicate = NSPredicate(format: "firstName = %@", name)
        let sortDescriptors = [NSSortDescriptor(key: "lastName", ascending: true)]
        
        if let results = fetchCandidates(predicate, sortDescriptors: sortDescriptors) {
            candidates = results
        }
        
        return candidates
    }
    
    func searchCandidateWithLastName(name: String) -> [Candidate] {
        var candidates = [Candidate]()
        
        let predicate = NSPredicate(format: "lastName = %@", name)
        let sortDescriptors = [NSSortDescriptor(key: "lastName", ascending: true)]
        
        if let results = fetchCandidates(predicate, sortDescriptors: sortDescriptors) {
            candidates = results
        }
        
        return candidates
    }
    
    func searchCandidateWithMail(mail: String) -> Candidate? {
        let predicate = NSPredicate(format: "mail = %@", mail)
        if let candidate = fetchCandidate(predicate) {
            return candidate
        }
        
        return nil
    }
    
    func getAllCandidates(sortField: String?) -> [Candidate] {
        var candidates = [Candidate]()
        
        var sortDescriptors = [NSSortDescriptor]()
        if let fields = sortField {
            sortDescriptors = [NSSortDescriptor(key: fields, ascending: true)]
        } else {
            sortDescriptors = [NSSortDescriptor(key: "lastName", ascending: true)]
        }
        
        if let results = fetchCandidates(nil, sortDescriptors: sortDescriptors) {
            candidates = results
        }
        
        return candidates
    }
    
    func createCandidate(lastname: String, firstname: String, mail: String,address: String,tel: String,mobile: String) -> Candidate? {
        if searchCandidateWithMail(mail) == nil {
            let entity = NSEntityDescription.entityForName("Candidate", inManagedObjectContext: contextObject!)
            
            let candidate = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: contextObject) as! Candidate
            candidate.firstName = firstname
            candidate.lastName = lastname
            candidate.mail = mail
            candidate.address = address
            candidate.tel = tel
            candidate.mobile = mobile
            
            var error: NSError? = nil
            contextObject!.save(&error)
            
            if error != nil {
                println(" Could not save context : \(error), \(error?.description) ")
            }
            
            return candidate
        }
        
        return nil
        
    }
    
    func deleteCandidate(candidate: Candidate?) {
        if let candidateValid = candidate {
            contextObject?.delete(candidateValid)
            contextObject?.save(nil)
        }
    }
}
