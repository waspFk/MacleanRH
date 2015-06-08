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
        var tmpRecruitments = self.valueForKey("recruitments") as! NSMutableSet
        tmpRecruitments.addObject(recruitment)
    }
    
    func removeRecruitment(recruitment: Recruitment) {
        var tmpRecruitments = self.valueForKey("recruitments") as! NSMutableSet
        tmpRecruitments.removeObject(recruitment)
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
        var tmpDegrees = self.valueForKey("degrees") as! NSMutableSet
        tmpDegrees.addObject(degree)
    }
    
    func removeDegree(degree: Degree) {
        var tmpDegrees = self.valueForKey("degrees") as! NSMutableSet
        tmpDegrees.removeObject(degree)
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
