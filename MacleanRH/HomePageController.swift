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
        println("--viewDidLoad")
        super.viewDidLoad()
        
        loadDataForApplication()
        
        let employees = EmployeeManager.SharedManager.getAllEmployees(nil)
        
        for e in employees {
            println("\(e.lastName) -- \(e.mail)")
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
        
        let dateString = "1990-10-09"
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.dateFromString(dateString)
        
        
        if SectorManager.SharedManager.searchRecruitment("Commercial") == nil {
            let s1 = SectorManager.SharedManager.createSector("Commercial")
            
            if let r1 = RecruitmentManager.SharedManager.createRecruitment("Recherche d'un chef de chantier",
                    workLibelle: "Chef de chantier",
                    workDescription: "On veux un chef de chantier carrefour",
                    date: NSDate(),
                    sector: s1) {
                        
                        if let c1 = CandidateManager.SharedManager.createCandidate("RB", firstname: "Baptiste", mail: "baptiste.thug_viennois@gmail.com",birthday: date!) {
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
                
                if let c2 = CandidateManager.SharedManager.createCandidate("M", firstname: "Cyril", mail: "cyril.meunier",birthday: date!) {
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
                    
                    if let c3 = CandidateManager.SharedManager.createCandidate("C", firstname: "Seb", mail: "c.seb@gmail.com",birthday: date!) {
                        c3.addRecruitment(r2)
                        
                        println("Candidate 3 : \(c3.lastName) - \(c3.firstName) : Nombre de recruitments : \(c3.recruitments.count)")
                        c3.managedObjectContext?.save(nil)
                    }
                    
                    if let c4 = CandidateManager.SharedManager.createCandidate("M", firstname: "Aurelien", mail: "m.aurel@gmail.com",birthday: date!) {
                        c4.addRecruitment(r2)
                        
                        if let d1 = DegreeManager.SharedManager.createDegree("test degree 1", date: NSDate(), candidate: c4)
                        {
                            c4.addDegree(d1)
                        }
                        
                        if let d2 = DegreeManager.SharedManager.createDegree("test degree 2", date: NSDate(), candidate: c4) {
                            c4.addDegree(d2)
                        }
                        
                        
                        println("Candidate 4 : \(c4.lastName) - \(c4.firstName) : Nombre de recruitments : \(c4.recruitments.count)")
                        c4.managedObjectContext?.save(nil)
                    }
                    
                    if let c5 = CandidateManager.SharedManager.searchCandidateWithMail("baptiste.thug_viennois@gmail.com") {
                        c5.addRecruitment(r2)
                        c5.managedObjectContext?.save(nil)
                    }
                    
                    println("Recruitment 2 : \(r2.workLibelle) : Nombre de candidats : \(r2.candidates.count) Secteur : \(r2.sector.libelle)")
                    r2.managedObjectContext?.save(nil)
                    
                    /*let typeContract = TypeContractManager.SharedManager.getTypeContract(TypeContractEnum.CDI)
                    println(typeContract.libelle)
                    
                    let candidate = CandidateManager.SharedManager.searchCandidateWithMail("m.aurel@gmail.com")
                    
                    if candidate!.address == nil {
                        candidate!.address = "Test address, 01000, Bourg"
                    }
                    
                    if candidate!.tel == nil {
                        candidate!.tel = "0385323136"
                    }
                    
                    if candidate!.mobile == nil {
                        candidate!.mobile = "0615203698"
                    }

                    
                    let contract1 = ContractManager.SharedManager.createContract("test Contract", salary: "5000", workLibelle: "Chef de chantier", typeContract: typeContract)
                    
                    contract1.candidate = candidate
                    contract1.dateStart = NSDate()
                    contract1.managedObjectContext?.save(nil)
                    println(contract1.libelle)
                    
                    let employee = EmployeeManager.SharedManager.createEmployee("1523875635593347",lastname: candidate!.lastName, firstname: candidate!.firstName, mail: candidate!.mail,contract: contract1)
                    employee?.addressLocalisation = candidate?.address
                    employee?.tel = candidate?.tel
                    employee?.mobile = candidate?.mobile
                    
                    employee?.managedObjectContext?.save(nil)
                    
                    
                    let candidate2 = CandidateManager.SharedManager.searchCandidateWithMail("baptiste.thug_viennois@gmail.com")
                    
                    if candidate2!.address == nil {
                        candidate2!.address = "Test address 2, 01000, Pont de Veyle"
                    }
                    
                    if candidate2!.tel == nil {
                        candidate2!.tel = "0385369214"
                    }
                    
                    if candidate2!.mobile == nil {
                        candidate2!.mobile = "0315742367"
                    }
                    
                    let contract2 = ContractManager.SharedManager.createContract("test Contract 2", salary: "5000", workLibelle: "Chef de chantier", typeContract: typeContract)
                    
                    contract2.candidate = candidate
                    contract2.dateStart = NSDate()
                    contract2.managedObjectContext?.save(nil)
                    
                    let employee2 = EmployeeManager.SharedManager.createEmployee("1523875635593347",lastname: candidate2!.lastName, firstname: candidate2!.firstName, mail: candidate2!.mail,contract: contract2)
                    employee2?.addressLocalisation = candidate2?.address
                    employee2?.tel = candidate2?.tel
                    employee2?.mobile = candidate2?.mobile
                    
                    employee2?.managedObjectContext?.save(nil)
                    
                    println(employee2?.addressLocalisation)*/
                    
                    /*println("Contract : \(contract1.libelle)")
                    println("Employee : \(contract1.employee?.lastName)")*/
                    
                    
            }
        }
        
        let employees = EmployeeManager.SharedManager.getAllEmployees(nil)
        println("Number Employee : \(employees.count)")
        
        
        
  
    }
    
    
    @IBAction func launchScanQrCode(sender: UIButton) {
        let qRCodeViewController = QRCodeViewController()
        self.navigationController?.pushViewController(qRCodeViewController, animated: true)
    }
    
    @IBAction func displayCalendar(sender: UIButton) {
        UIApplication.sharedApplication().openURL(NSURL(string: "calshow://")!)
    }
}
