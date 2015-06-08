//
//  Recruitment.swift
//  MacleanRH
//
//  Created by iem on 03/06/2015.
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
    @NSManaged var sector:Sector
}

extension Recruitment {
    
    func addCandidate(candidate: Candidate) {
        var tmpCandidates = self.valueForKey("candidates") as! NSMutableSet
        tmpCandidates.addObject(candidate)
    }
    
    func removeRecruitment(candidate: Candidate) {
        var tmpCandidates = self.valueForKey("candidates") as! NSMutableSet
        tmpCandidates.removeObject(candidate)
    }
    
    func countCandidates() -> Int {
        return self.candidates.count
    }
    
    func getCandidates() -> [Candidate] {
        var tmpCandidates = [Candidate]()
        
        tmpCandidates = self.candidates.allObjects as! [Candidate]
        
        return tmpCandidates
    }
}
