//
//  Dating.swift
//  MacleanRH
//
//  Created by iem on 04/06/2015.
//  Copyright (c) 2015 iem. All rights reserved.
//

import Foundation
import CoreData

class Dating: NSManagedObject {

    @NSManaged var libelle: String
    @NSManaged var dateStart: NSDate
    @NSManaged var dateEnd: NSDate
    @NSManaged var recruitment: Recruitment
    @NSManaged var candidates: NSSet
    
  

}

extension Dating {
    func addCandidate(candidate: Candidate) {
        var candidates = self.valueForKey("candidates") as! NSMutableSet
        candidates.addObject(candidate)
    }
    
    
    func countCandidate() -> Int {
        return self.candidates.count
    }
    
    
    func getCandiate() -> [Candidate] {
        var tmpCandidates = [Candidate]()
        
        tmpCandidates = self.candidates.allObjects as! [Candidate]
        
        return tmpCandidates
    }
    
    
    func removeCandidate(candidate: Candidate){
        var candidates = self.valueForKey("candidates") as! NSMutableSet
        candidates.removeObject(candidate)
    }
}
