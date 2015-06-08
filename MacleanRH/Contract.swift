//
//  Contract.swift
//  MacleanRH
//
//  Created by iem on 03/06/2015.
//  Copyright (c) 2015 iem. All rights reserved.
//

import Foundation
import CoreData

class Contract: NSManagedObject {

    @NSManaged var dateEnd: NSDate?
    @NSManaged var dateStart: NSDate?
    @NSManaged var libelle: String?
    @NSManaged var salary: String?
    @NSManaged var signatureCandidate: NSData?
    @NSManaged var signatureEmployee: NSData?
    @NSManaged var workLibelle: String?
    @NSManaged var specialCondition: String?
    @NSManaged var employee: Employee?
    @NSManaged var typeContract: TypeContract?
    @NSManaged var candidate: Candidate?

}
