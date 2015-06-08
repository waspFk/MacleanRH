//
//  Candidate.swift
//  MacleanRH
//
//  Created by iem on 08/06/2015.
//  Copyright (c) 2015 iem. All rights reserved.
//

import Foundation
import CoreData

class Candidate: NSManagedObject {

    @NSManaged var address: String?
    @NSManaged var birthday: NSDate?
    @NSManaged var cadre: NSNumber?
    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var mail: String
    @NSManaged var mobile: String?
    @NSManaged var photo: NSData?
    @NSManaged var seniority: NSNumber?
    @NSManaged var tel: String?
    @NSManaged var degrees: NSSet?
    @NSManaged var recruitments: NSSet
    @NSManaged var state_candidature: StateCandidature

}

extension Candidate {
    func getRecruitmentsArray() -> [Recruitment] {
        return self.recruitments.allObjects as! [Recruitment]
    }
    
    func countRecruitments() -> Int {
        return self.recruitments.count
    }
    
    func addRecruitment(recruitment:Recruitment){
        self.mutableSetValueForKey("recruitments").addObject(recruitment)
    }
    
    func removeRecruitment(recruitment:Recruitment){
        self.mutableSetValueForKey("recruitments").removeObject(recruitment)
    }
    
    func getDegrees() -> [Degree] {
        return self.degrees.allObjects as! [Degree]
    }
    
    func countDegrees() -> Int {
        return self.degrees.count
    }
    
    func addDegree(degree:Degree){
        self.mutableSetValueForKey("degrees").addObject(degree)
    }
    
    func removeDegree(degree:Degree){
        self.mutableSetValueForKey("degrees").removeObject(degree)
    }
}