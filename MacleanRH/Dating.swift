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
    func getCandidatesArray() -> [Candidate] {
        return self.candidates.allObjects as! [Candidate]
    }
    
    func countCandidates() -> Int {
        return self.candidates.count
    }
    
    func addCandidate(candidate:Candidate){
        self.mutableSetValueForKey("candidates").addObject(candidate)
    }
    
    func removeCandidate(candidate:Candidate){
        self.mutableSetValueForKey("candidates").removeObject(candidate)
    }
}
