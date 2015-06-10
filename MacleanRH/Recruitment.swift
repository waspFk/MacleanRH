//
//  Recruitment.swift
//  MacleanRH
//
//  Created by iem on 08/06/2015.
//  Copyright (c) 2015 iem. All rights reserved.
//

import Foundation
import CoreData

class Recruitment: NSManagedObject {

    @NSManaged var date: NSDate
    @NSManaged var titre: String
    @NSManaged var workDescription: String?
    @NSManaged var workLibelle: String
    @NSManaged var candidates: NSSet
    @NSManaged var sector: Sector
    @NSManaged var typeContract: TypeContract?

}

extension Recruitment {
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
