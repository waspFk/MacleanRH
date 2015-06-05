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
    @NSManaged var dating_recruitment: Recruitment
    @NSManaged var dating_candidate: Candidate

}
