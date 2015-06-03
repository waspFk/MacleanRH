//
//  Degree.swift
//  MacleanRH
//
//  Created by iem on 03/06/2015.
//  Copyright (c) 2015 iem. All rights reserved.
//

import Foundation
import CoreData

class Degree: NSManagedObject {

    @NSManaged var date: NSDate
    @NSManaged var libelle: String
    @NSManaged var degree_candidate: Candidate

}
