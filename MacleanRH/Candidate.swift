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

    @NSManaged var birthDay: NSDate?
    @NSManaged var cadre: NSNumber?
    @NSManaged var firstName: String?
    @NSManaged var lastName: String?
    @NSManaged var mail: String?
    @NSManaged var photo: NSData?
    @NSManaged var tel: String?
    @NSManaged var address: String?
    @NSManaged var mobile: String?
    @NSManaged var seniority: NSNumber?
    @NSManaged var candidate_recruitment: NSSet?

}
