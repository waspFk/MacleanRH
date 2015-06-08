//
//  Candidate.swift
//  MacleanRH
//
//  Created by iem on 03/06/2015.
//  Copyright (c) 2015 iem. All rights reserved.
//

import Foundation
import CoreData

class Candidate: NSManagedObject {

    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var mail: String
    @NSManaged var birthday: NSDate?
    @NSManaged var cadre: NSNumber?
    @NSManaged var photo: NSData?
    @NSManaged var tel: String?
    @NSManaged var address: String?
    @NSManaged var mobile: String?
    @NSManaged var seniority: NSNumber?
    @NSManaged var state_candidate: StateCandidature?
    @NSManaged var recruitments: NSSet
    @NSManaged var degrees: NSSet
}

extension Candidate {
    
    func addRecruitment(recruitment: Recruitment) {
        var recruitments = self.mutableSetValueForKey("recruitments")
        recruitments.addObject(recruitment)
    }
    
    func countRecruitments() -> Int {
        return self.recruitments.count
    }
    
    func getRecruitmens() -> [Recruitment] {
        var tmpRecruitments = [Recruitment]()
        
        tmpRecruitments = self.recruitments.allObjects as! [Recruitment]
        
        return tmpRecruitments
    }
    
    func addDegree(degree: Degree) {
        var degrees = self.mutableSetValueForKey("degrees")
        degrees.addObject(degree)
    }
    
    func countDegrees() -> Int {
        return self.degrees.count
    }
    
    func getDegrees() -> [Degree] {
        var tmpDegrees = [Degree]()
        
        tmpDegrees = self.degrees.allObjects as! [Degree]
        
        return tmpDegrees
    }
}
