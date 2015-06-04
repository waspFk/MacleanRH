//
//  HomePageController.swift
//  MacleanRH
//
//  Created by iem on 04/06/2015.
//  Copyright (c) 2015 iem. All rights reserved.
//

import UIKit

class HomePageController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let c1 = CandidateManager.SharedManager.createCandidate("RB", firstname: "Baptiste", mail: "baptiste.thug_viennois@gmail.com") {
            println("Candidate 1 : \(c1.lastName) - \(c1.firstName)")
            c1.address = "rb.b@gmail.com"
            c1.tel = "0104070104"
            c1.mobile = "0205080205"
            c1.managedObjectContext!.save(nil)
        }
        
        if let c2 = CandidateManager.SharedManager.createCandidate("M", firstname: "Cyril", mail: "cyril.meunier") {
            println("Candidate 2 : \(c2.lastName) - \(c2.firstName)")
            c2.address = "m.c@gmail.com"
            c2.tel = "0104070104"
            c2.mobile = "0205080205"
            c2.managedObjectContext!.save(nil)
        }
        
        if let c3 = CandidateManager.SharedManager.createCandidate("C", firstname: "Seb", mail: "c.seb@gmail.com") {
            println("Candidate 3 : \(c3.lastName) - \(c3.firstName)")
            c3.address = "c.s@gmail.com"
            c3.tel = "0104070104"
            c3.mobile = "0205080205"
            c3.managedObjectContext!.save(nil)
        }
        
        if let c4 = CandidateManager.SharedManager.createCandidate("M", firstname: "Aurelien", mail: "urel@gmail.com") {
            println("Candidate 4 : \(c4.lastName) - \(c4.firstName)")
            c4.address = "m.a@gmail.com"
            c4.tel = "0104070104"
            c4.mobile = "0205080205"
            c4.managedObjectContext!.save(nil)
        }
    }
    
}
