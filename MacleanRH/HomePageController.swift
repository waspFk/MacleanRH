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
        }
        
        if let c2 = CandidateManager.SharedManager.createCandidate("M", firstname: "Cyril", mail: "cyril.meunier") {
            println("Candidate 2 : \(c2.lastName) - \(c2.firstName)")
        }
        
        if let c3 = CandidateManager.SharedManager.createCandidate("C", firstname: "Seb", mail: "c.seb@gmail.com") {
            println("Candidate 3 : \(c3.lastName) - \(c3.firstName)")
        }
        
        if let c4 = CandidateManager.SharedManager.createCandidate("M", firstname: "Aurelien", mail: "m.aurel@gmail.com") {
            println("Candidate 4 : \(c4.lastName) - \(c4.firstName)")
        }
    }
    
}
