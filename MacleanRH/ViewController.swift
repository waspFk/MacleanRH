//
//  ViewController.swift
//  MacleanRH
//
//  Created by iem on 02/06/2015.
//  Copyright (c) 2015 iem. All rights reserved.
//

import UIKit
import EventKit
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Calendar
    
    func testCalendar(){
        println(" -- TEST CALENDAR -- ")
        
        let eventStore = EKEventStore()
        
        switch EKEventStore.authorizationStatusForEntityType(EKEntityTypeEvent) {
        case .Authorized:
            insertEvent(eventStore)
        case .Denied:
            println("Access denied")
        case .NotDetermined:
            eventStore.requestAccessToEntityType(EKEntityTypeEvent, completion:
                {[weak self] (granted: Bool, error: NSError!) -> Void in
                    if granted {
                        self!.insertEvent(eventStore)
                    } else {
                        println("Access denied")
                    }
                })
        default:
            println("Case Default")
        }
    }
    
    func insertEvent(store: EKEventStore) {
        let calendars = store.calendarsForEntityType(EKEntityTypeEvent)
            as! [EKCalendar]
        
        for calendar in calendars {
            if calendar.title == "Calendar" {
                let startDate = NSDate()
                let endDate = startDate.dateByAddingTimeInterval(2 * 60 * 60)
                // Create Event
                var event = EKEvent(eventStore: store)
                event.calendar = calendar
                
                event.title = "Test"
                event.startDate = startDate
                event.endDate = endDate
                // Save Event in Calendar
                var error: NSError?
                let result = store.saveEvent(event, span: EKSpanThisEvent, error: &error)
                
                if result == false {
                    if let theError = error {
                        println("An error occured \(theError)")
                    }
                }
                let events  = fetchEvents(store)
                for e in events{
                    println(e.title)
                    println(e.startDate)
                }
            }
        }
    }
    
    // MARK: Mail
    
    func testSendMail(){
        println(" -- TEST SEND MAIL -- ")
        
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        // Email du destinataire
        mailComposerVC.setToRecipients(["baptiste.briot@gmail.com"])
        // Sujet du mail
        mailComposerVC.setSubject("Mail de test ...")
        // Corp du mail
        mailComposerVC.setMessageBody("Bonjour, ceci est un test !", isHTML: false)
        
        if let filePath = NSBundle.mainBundle().pathForResource("ERDDiagram_MacleanRH_v2", ofType: "png") {
            println("File path loaded.")
            if let fileData = NSData(contentsOfFile: filePath) {
                println("File data loaded.")
                mailComposerVC.addAttachmentData(fileData, mimeType: "image/png", fileName: "ERDDiagram_MacleanRH_v2")
            }
        }
        
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposerVC, animated: true, completion: nil)
        } else {
            let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
            sendMailErrorAlert.show()
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func fetchEvents(store: EKEventStore) -> NSMutableArray{
        let endDate = NSDate(timeIntervalSinceNow: 604800*10);
        let predicate = store.predicateForEventsWithStartDate(NSDate(), endDate: NSDate(), calendars: nil)
        let events = NSMutableArray(array: store.eventsMatchingPredicate(predicate))
        return events
    }
    
    // MARK: StateCandidature
    
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
    
    // MARK: TypeContract
    
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
    
    // MARK: Recruitment
    
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
    
    // MARK: Contract
    
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

