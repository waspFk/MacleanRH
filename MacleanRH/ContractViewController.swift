//
//  ContractViewController.swift
//  MacleanRH
//
//  Created by iem on 09/06/2015.
//  Copyright (c) 2015 iem. All rights reserved.
//

import UIKit
import MessageUI

class ContractViewController: UIViewController, UIWebViewDelegate, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var contractView: UIWebView!
    var url: String?
    var name: String?
    var candidate: Candidate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let request = NSURLRequest(URL: NSURL(fileURLWithPath: url!)!)
        contractView.loadRequest(request)
    }
    
    @IBAction func validateContract(sender: AnyObject) {
        sendMailConfirm()
    }
    
    @IBAction func cancelContract(sender: AnyObject) {
        
    }
    
    func sendMailConfirm(){
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["maclean-manager-rh@yopmail.com"])
        mailComposerVC.setSubject("Contrat \(candidate!.lastName) \(candidate!.firstName)")
        mailComposerVC.setMessageBody("Voici le contrat comme convenu .", isHTML: false)
        
        if let fileData = NSData(contentsOfFile: url!) {
            mailComposerVC.addAttachmentData(fileData, mimeType: "application/pdf", fileName: name)
        }
        
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposerVC, animated: true, completion: nil)
        } else {
            let sendMailErrorAlert = UIAlertView(title: "Envoi impossible", message: "Votre périphérique ne peut envoyer de mail. Merci de vérifier votre configuration et de réessayer l'envoi.", delegate: self, cancelButtonTitle: "OK")
            sendMailErrorAlert.show()
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}
