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
    
    func testContract()
    {
        println(" -- TEST CONTRACT -- ")
        
        var contracts: [Contract]
        var contract: Contract
        var typeContract = TypeContractManager.SharedManager.getTypeContract(TypeContractEnum.CDI)
        
        
        /*println(" ---- Add Test ---- ")
        ContractManager.SharedManager.createContract("Contract 1",salary: "2000",workLibelle: "Test libelle",typeContract: typeContract)
        ContractManager.SharedManager.createContract("Contract 2",salary: "1500",workLibelle: "Test libelle",typeContract: typeContract)*/
        
        
        println(" ---- Display Test ---- ")
        
        contracts = ContractManager.SharedManager.getAllContracts(nil)
        for contractVal in contracts
        {
            println(contractVal.libelle!+" -- "+contractVal.contract_typeContract!.libelle!)
        }
        
        println(" ---- Search Test ---- ")
        contract = ContractManager.SharedManager.searchContract("libelle",data: "Contract 2")!
        println(contract.libelle!+" -- "+contract.contract_typeContract!.libelle!)
        
        
        println(" ---- Delete Test ---- ")
        ContractManager.SharedManager.deleteContract(contract)
        
        contracts = ContractManager.SharedManager.getAllContracts(nil)
        
        for contractVal in contracts
        {
            println(contractVal.libelle! + " -- " + contractVal.contract_typeContract!.libelle!)
        }
    }
}

