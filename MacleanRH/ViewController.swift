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
    
    func testRecruitment()
    {
        var newRecruitment: Recruitment!
        var recruitments: [Recruitment]!
        
        newRecruitment.titre="Test recruitment 1"
        newRecruitment.workDescription = "Work test libellé"
        newRecruitment.workDescription = "Work test description"
        newRecruitment.date = NSDate()
        
        RecruitmentManager.SharedManager.createRecruitment(newRecruitment)
        
        recruitments = RecruitmentManager.SharedManager.getAllRecruitments()
        
        for recruitment in recruitments
        {
            println(recruitment.titre)
        }
        
    }
}

