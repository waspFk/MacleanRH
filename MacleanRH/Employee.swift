//
//  Employee.swift
//  MacleanRH
//
//  Created by iem on 03/06/2015.
//  Copyright (c) 2015 iem. All rights reserved.
//

import Foundation
import CoreData

class Employee: NSManagedObject {

    @NSManaged var numeroSAP: String
    @NSManaged var lastName: String
    @NSManaged var firstName: String
    @NSManaged var photo: NSData?
    @NSManaged var addressLocalisation: String?
    @NSManaged var mail: String
    @NSManaged var tel: String?
    @NSManaged var mobile: String?
    @NSManaged var birthDay: NSDate?
    @NSManaged var seniority: NSDate?
    @NSManaged var cadre: NSNumber?
    @NSManaged var workLibelle: String?
    @NSManaged var dailyRate: NSDecimalNumber?
    @NSManaged var contract: Contract

}
