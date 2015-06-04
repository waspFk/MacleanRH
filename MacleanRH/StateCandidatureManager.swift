//
//  StateCandidatureManager.swift
//  MacleanRH
//
//  Created by iem on 03/06/2015.
//  Copyright (c) 2015 iem. All rights reserved.
//

import Foundation
import CoreData

enum StateCanidatureEnum : String {
    case ValidateCandidature            = "validate_candidature"
    case RefuseCantidature              = "refuse_candidature"
    case IcompleteCandidature           = "incomplete_candidature"
    case WaittingValideCandidature      = "finish_candidature"
    case WaitingSignatureCandidature    = "waiting_signature_candidature"
    case FinishCandidature              = "waiting_validate_candidature"
    
    static let allValues = [ValidateCandidature, RefuseCantidature, IcompleteCandidature, WaittingValideCandidature, WaitingSignatureCandidature, FinishCandidature]
}

class StateCandidatureManager
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
    
    class var SharedManager: StateCandidatureManager {
        struct Singleton {
            static let instance = StateCandidatureManager()
        }
        
        Singleton.instance.coreData = CoreDataManager.SharedManager
        return Singleton.instance
    }
    
    private func fetchStatesCandidatures(predicate : NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> [StateCandidature]? {
        let fetchRequest = NSFetchRequest(entityName: "StateCandidature")
        
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        
        var error: NSError? = nil
        
        let results = contextObject!.executeFetchRequest(fetchRequest, error: &error) as! [StateCandidature]
        
        if results.count > 0 {
            return results
        }
        
        if error != nil {
            println(" Could not fetch data : \(error), \(error?.description) ")
        }
        
        return nil
    }
    
    private func fetchStateCandidature(predicate : NSPredicate) -> StateCandidature? {
        if let states = fetchStatesCandidatures(predicate, sortDescriptors: nil) {
            return states[0]
        }
        
        return nil
    }
    
    
    private func createStateCandidature(enumState : StateCanidatureEnum) -> StateCandidature {
        let entity = NSEntityDescription.entityForName("StateCandidature", inManagedObjectContext: contextObject!)
        
        let stateCandidature = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: contextObject)as! StateCandidature
        
        stateCandidature.libelle = enumState.rawValue
        stateCandidature.color = getColorForState(enumState)
        
        var error: NSError? = nil
        contextObject!.save(&error)
        
        if error != nil {
            println(" Could not save context : \(error), \(error?.description) ")
        }
        
        return stateCandidature
    }
    
    private func getColorForState(stateCandidature :StateCanidatureEnum) -> String {
        switch (stateCandidature){
        case .ValidateCandidature:
            return "#12d400"
            
        case .RefuseCantidature:
            return "#ff0000"
            
        case .IcompleteCandidature:
            return "#eb5401"
            
        case .WaittingValideCandidature:
            return "#00aeef"
            
        case .WaitingSignatureCandidature:
            return "#00688f"
            
        case .FinishCandidature:
            return "#009939"
            
        default:
            return "#fff"
        }
    }
    
    func determinateStateCandidature(name: String?) -> StateCandidature? {
        if let stringValue = name {
            let predicate = NSPredicate(format: "libelle = %@", stringValue)
            if let stateCandidature = fetchStateCandidature(predicate) {
                return stateCandidature
            }
        }
        
        return nil
    }
    
    func getAllStates () -> [StateCandidature] {
        var states = [StateCandidature]()
        
        let sortDescriptors = [NSSortDescriptor(key: "libelle", ascending: true)]
        
        if let results = fetchStatesCandidatures(nil, sortDescriptors: sortDescriptors) {
            states = results
        }
        
        return states
    }
    
    func getState(stateEnum : StateCanidatureEnum) -> StateCandidature {
        var state:StateCandidature
        
        let predicate = NSPredicate(format: "libelle = %@", stateEnum.rawValue)
        if let stateCandidature = fetchStateCandidature(predicate) {
            state = stateCandidature
        } else {
            state = createStateCandidature(stateEnum)
        }
        
        return state
    }
}
