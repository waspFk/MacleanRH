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
    @NSManaged var workDescription: String
    @NSManaged var workLibelle: String
    @NSManaged var recruitment_etatCandidature: StateCandidature
    @NSManaged var reruitment_candidate: NSSet
    
   

}
