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
        
        println("--viewDidLoad")
        /*var recru1:Recruitment?
        var recru2:Recruitment?
        
        if let r1 = RecruitmentManager.SharedManager.createRecruitment("Recherche d'un chef de chantier", workLibelle: "Chef de chantier", workDescription: "On veux un chef de chantier un carrefour", date: NSDate()) {
            println("Recruitment 1 : \(r1.workLibelle)")
            recru1 = r1
        }
        
        if let r2 = RecruitmentManager.SharedManager.createRecruitment("Recherche d'une femme ménagère", workLibelle: "Chef de chantier", workDescription: "On veux un chef de chantier un carrefour", date: NSDate()) {
            println("Recruitment 2 : \(r2.workLibelle)")
            recru2 = r2
        }
        
        if let c1 = CandidateManager.SharedManager.createCandidate("RB", firstname: "Baptiste", mail: "baptiste.thug_viennois@gmail.com") {
            println("Candidate 1 : \(c1.lastName) - \(c1.firstName)")
            c1.candidate_recruitment?.setByAddingObject(recru1!)
            c1.managedObjectContext?.save(nil)
        }
        
        if let c2 = CandidateManager.SharedManager.createCandidate("M", firstname: "Cyril", mail: "cyril.meunier") {
            println("Candidate 2 : \(c2.lastName) - \(c2.firstName)")
            c2.candidate_recruitment?.setByAddingObject(recru1!)
            c2.managedObjectContext?.save(nil)
        }
        
        if let c3 = CandidateManager.SharedManager.createCandidate("C", firstname: "Seb", mail: "c.seb@gmail.com") {
            println("Candidate 3 : \(c3.lastName) - \(c3.firstName)")
            c3.candidate_recruitment?.setByAddingObject(recru2!)
            c3.managedObjectContext?.save(nil)
        }
        
        if let c4 = CandidateManager.SharedManager.createCandidate("M", firstname: "Aurelien", mail: "m.aurel@gmail.com") {
            println("Candidate 4 : \(c4.lastName) - \(c4.firstName)")
            c4.candidate_recruitment?.setByAddingObject(recru2!)
            c4.managedObjectContext?.save(nil)
        }*/
    }
    
}
