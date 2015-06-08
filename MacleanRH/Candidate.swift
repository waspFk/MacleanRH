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
    
    func addRecruitment(recruitment:Recruitment) {
        var recruitments = self.mutableSetValueForKey("recruitments")
        recruitments.addObject(recruitment)
    }
    
}
