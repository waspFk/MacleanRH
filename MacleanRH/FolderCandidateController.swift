//
//  FolderCandidateController.swift
//  MacleanRH
//
//  Created by iem on 04/06/2015.
//  Copyright (c) 2015 iem. All rights reserved.
//

import UIKit

class FolderCandidateController: UIViewController
{
    
    @IBOutlet weak var libLastName: UITextField!
    @IBOutlet weak var libFirstName: UITextField!
    @IBOutlet weak var libMail: UITextField!
    @IBOutlet weak var libAdresse: UITextView!
    @IBOutlet weak var libTel: UITextField!
    @IBOutlet weak var libMobile: UITextField!
    @IBOutlet weak var libPoste: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let candidates = CandidateManager.SharedManager.getAllCandidates("lastName")
        
        /*let recruitment = RecruitmentManager.SharedManager.createRecruitment("Nouveau poste", workLibelle: "Informatique", workDescription: "Administrateur réseau", date: NSDate())*/

        //CandidateManager.SharedManager.createCandidate("Meunier", firstname: "Cyril", mail: "cyril.meunier71@gmail.com",address: "19 impasse du tilleul \n 71960\n Milly-Lamartine",tel: "0610203645",mobile: "0385331460")

        let candidate = CandidateManager.SharedManager.searchCandidateWithMail("cyril.meunier71@gmail.com")
        
        /*candidate?.candidate_recruitment.setByAddingObject(recruitment)
        candidate?.managedObjectContext?.save(nil)*/
        
        libLastName.text = candidate!.lastName
        libFirstName.text = candidate!.firstName
        libMail.text = candidate?.mail
        libAdresse.text = candidate?.address
        libTel.text = candidate?.tel
        libMobile.text = candidate?.mobile
        
        
    }
}
