//
//  HomePageController.swift
//  MacleanRH
//
//  Created by iem on 04/06/2015.
//  Copyright (c) 2015 iem. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomePageController: UIViewController {
    
    override func viewDidLoad() {
        println("--viewDidLoad")
        super.viewDidLoad()
        
        loadDataForApplication()
        
        if let data = RecruitmentManager.SharedManager.searchRecruitment("Recherche d\'un chef de chantier") {
            println("---DATA = \(data.objectID)")
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
    func loadDataForApplication() {
        if SectorManager.SharedManager.searchRecruitment("Commercial") == nil {
            let s1 = SectorManager.SharedManager.createSector("Commercial")
            
            if let r1 = RecruitmentManager.SharedManager.createRecruitment("Recherche d'un chef de chantier",
                    workLibelle: "Chef de chantier",
                    workDescription: "On veux un chef de chantier carrefour",
                    date: NSDate(),
                    sector: s1) {
                        
                if let c1 = CandidateManager.SharedManager.createCandidate("RB", firstname: "Baptiste", mail: "baptiste.thug_viennois@gmail.com") {
                    c1.addRecruitment(r1)
                    
                    println("Candidate 1 : \(c1.lastName) - \(c1.firstName) : Nombre de recruitments : \(c1.recruitments.count)")
                    c1.managedObjectContext?.save(nil)
                    if let d1 = DegreeManager.SharedManager.createDegree("test degree 1", date: NSDate(), candidate: c1)
                    {
                        c1.addDegree(d1)
                    }
                    
                    if let d2 = DegreeManager.SharedManager.createDegree("test degree 2", date: NSDate(), candidate: c1) {
                        c1.addDegree(d2)
                    }
                }
                
                if let c2 = CandidateManager.SharedManager.createCandidate("M", firstname: "Cyril", mail: "cyril.meunier") {
                    c2.addRecruitment(r1)
                    
                    println("Candidate 2 : \(c2.lastName) - \(c2.firstName) : Nombre de recruitments : \(c2.recruitments.count)")
                    c2.managedObjectContext?.save(nil)
                }
                        
                
                
                
                
                        
                        
                println("Recruitment 1 : \(r1.workLibelle) : Nombre de candidats : \(r1.candidates.count) Secteur : \(r1.sector.libelle)")
                r1.managedObjectContext?.save(nil)
            }
            
        }
        
        
        if SectorManager.SharedManager.searchRecruitment("Informatique") == nil {
            let s1 = SectorManager.SharedManager.createSector("Informatique")
            
            if let r2 = RecruitmentManager.SharedManager.createRecruitment("Recherche d'une femme ménagère",
                    workLibelle: "Femme de ménage",
                    workDescription: "On veux une femme de menage carrefour",
                    date: NSDate(),
                    sector: s1) {
                
                if let c3 = CandidateManager.SharedManager.createCandidate("C", firstname: "Seb", mail: "c.seb@gmail.com") {
                    c3.addRecruitment(r2)
                    
                    println("Candidate 3 : \(c3.lastName) - \(c3.firstName) : Nombre de recruitments : \(c3.recruitments.count)")
                    c3.managedObjectContext?.save(nil)
                }
                
                if let c4 = CandidateManager.SharedManager.createCandidate("M", firstname: "Aurelien", mail: "m.aurel@gmail.com") {
                    c4.addRecruitment(r2)
                    
                    println("Candidate 4 : \(c4.lastName) - \(c4.firstName) : Nombre de recruitments : \(c4.recruitments.count)")
                    c4.managedObjectContext?.save(nil)
                }
                        
                        if let c5 = CandidateManager.SharedManager.searchCandidateWithMail("baptiste.thug_viennois@gmail.com") {
                            c5.addRecruitment(r2)
                            c5.managedObjectContext?.save(nil)
                        }
                
                
                
                println("Recruitment 2 : \(r2.workLibelle) : Nombre de candidats : \(r2.candidates.count) Secteur : \(r2.sector.libelle)")
                r2.managedObjectContext?.save(nil)
                        
                let typeContract = TypeContractManager.SharedManager.getTypeContract(TypeContractEnum.CDI)
                println(typeContract.libelle)
                        
                let candidate = CandidateManager.SharedManager.searchCandidateWithMail("m.aurel@gmail.com")
                let contract1 = ContractManager.SharedManager.createContract("test Contract", salary: "5000", workLibelle: "Test Lib", typeContract: typeContract)
                        
                contract1.candidate = candidate
                contract1.managedObjectContext?.save(nil)
                println(contract1.libelle)
                        
                let employee = EmployeeManager.SharedManager.createEmployee("1523875635593347",lastname: candidate!.lastName, firstname: candidate!.firstName, mail: candidate!.mail,contract: contract1)
                println(employee?.firstName)
                        
                /*println("Contract : \(contract1.libelle)")
                println("Employee : \(contract1.employee?.lastName)")*/
            
        
            }
        }
        
        let employees = EmployeeManager.SharedManager.getAllEmployees(nil)
        println("Number Employee : \(employees.count)")
        
        
        
  
    }
    
    @IBAction func displayCalendar(sender: UIButton) {
        UIApplication.sharedApplication().openURL(NSURL(string: "calshow://")!)
    }
}
