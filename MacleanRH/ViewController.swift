//
//  ViewController.swift
//  MacleanRH
//
//  Created by iem on 02/06/2015.
//  Copyright (c) 2015 iem. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        testStateCandidature()
        
        testTypeContract()
        
        testRecruitment()
        
    }
    
    func testStateCandidature () {
        println(" -- TEST STATE CANDIDATURE -- ")
        
        let managerStateCandidature = StateCandidatureManager.SharedManager
        
        var state = managerStateCandidature.getState(.ValidateCandidature)
        println("J'ai trouve l'état : \(state.libelle)")
        
        state = managerStateCandidature.getState(.RefuseCantidature)
        println("J'ai trouve l'état : \(state.libelle)")
        
        state = managerStateCandidature.getState(.IcompleteCandidature)
        println("J'ai trouve l'état : \(state.libelle)")
        
        state = managerStateCandidature.getState(.WaittingValideCandidature)
        println("J'ai trouve l'état : \(state.libelle)")
        
        state = managerStateCandidature.getState(.WaitingSignatureCandidature)
        println("J'ai trouve l'état : \(state.libelle)")
        
        state = managerStateCandidature.getState(.FinishCandidature)
        println("J'ai trouve l'état : \(state.libelle)")
        
        var states = managerStateCandidature.getAllStates()
        for stateCandidate in states {
            println(" -- \(stateCandidate.libelle)")
            println(" -- \(stateCandidate.color)")
        }
    }
    
    func testTypeContract () {
        println(" -- TEST TYPE CONTRACT -- ")
        
        let managerTypeContract = TypeContractManager.SharedManager
        
        var type = managerTypeContract.getTypeContract(.CDI)
        println("J'ai trouve le contrat : \(type.libelle)")
        
        type = managerTypeContract.getTypeContract(.CDD)
        println("J'ai trouve le contrat : \(type.libelle)")
        
        var types = managerTypeContract.getAllTypes()
        for typeContract in types {
            println(" -- \(typeContract.libelle)")
        }
    }
    
    func testRecruitment() {
        println(" -- TEST RECRUITEMENT -- ")
        println(" ---- Check ---- ")
        var recruitments: [Recruitment]
        var recruitment: Recruitment
        
        println(" ---- Add Test ---- ")
        RecruitmentManager.SharedManager.createRecruitment("Test recruitment 1",workLibelle: "Work test libellé",workDescription: "Work test description",date: NSDate())
        RecruitmentManager.SharedManager.createRecruitment("Test recruitment 2",workLibelle: "Work test libellé",workDescription: "Work test description",date: NSDate())
        recruitments = RecruitmentManager.SharedManager.getAllRecruitments(nil)
        
        println(" ---- Display Test ---- ")
        for recruitment in recruitments
        {
            println(recruitment.titre)
        }
        
        println(" ---- Search Test ---- ")
        recruitment = RecruitmentManager.SharedManager.searchRecruitment("Test recruitment 1")!
        println(recruitment.titre)
        
        println(" ---- Delete Test ---- ")
        RecruitmentManager.SharedManager.deleteRecruitment(recruitment)
        
        recruitments = RecruitmentManager.SharedManager.getAllRecruitments(nil)
        
        for recruitment in recruitments
        {
            println(recruitment.titre)
        }
        
    }
}

