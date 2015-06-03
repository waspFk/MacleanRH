//
//  InitDataViewController.swift
//  MacleanRH
//
//  Created by iem on 03/06/2015.
//  Copyright (c) 2015 iem. All rights reserved.
//

import UIKit

class initDataViewController: UIViewController {
    
    @IBOutlet var txtnameState: UITextField!
    var stateCandidatures: [StateCandidature] = [StateCandidature]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func initEtat(sender: AnyObject) {
        
        var libelle = txtnameState.text
        EtatCandidatureManager.SharedManager.createStateWithName(libelle)
        
    }
    
    @IBAction func listState(sender: AnyObject) {
        stateCandidatures = EtatCandidatureManager.SharedManager.getState()
        
        println(stateCandidatures.count)
        
        for state in stateCandidatures
        {
            println(state.libelle)
        }
    }
}
