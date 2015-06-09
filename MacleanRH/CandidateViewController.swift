//
//  CandidateViewController.swift
//  MacleanRH
//
//  Created by iem on 04/06/2015.
//  Copyright (c) 2015 iem. All rights reserved.
//

import UIKit
import AVFoundation
import EventKit
import MessageUI

class CandidateViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPopoverPresentationControllerDelegate, UITableViewDelegate, UITableViewDataSource,MFMailComposeViewControllerDelegate {
    var candidateSeleted:Candidate!
    var recruitment: Recruitment!
    var candidates:[Candidate]!

    
    @IBOutlet weak var libLastName: UITextField!
    @IBOutlet weak var libFirstName: UITextField!
    @IBOutlet weak var libMail: UITextField!
    @IBOutlet weak var libAdresse: UITextField!
    @IBOutlet weak var libTel: UITextField!
    @IBOutlet weak var libMobile: UITextField!
    @IBOutlet weak var libPoste: UITextField!
    @IBOutlet weak var imgImageCandidate: UIImageView!
    @IBOutlet weak var libSector: UITextField!
    @IBOutlet weak var tableViewCandidate: UITableView!
    
    var photoData: NSData!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imgImageCandidate.frame = CGRectMake(0, 0, 200, 200)
        
        initRecruitment()
        changeCandidateView(candidateSeleted)
    }
    
    // MARK: - UI Helper
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage
        image: UIImage!,
        editingInfo: [NSObject : AnyObject]!) {
            
            self.imgImageCandidate.image = image
            self.dismissViewControllerAnimated(true, completion: nil)
            
            photoData = UIImageJPEGRepresentation(image, 100)
    }
    
    func initRecruitment(){
        candidates = recruitment.getCandidatesArray()
        
        libPoste.text = recruitment.workLibelle
        libSector.text = recruitment.sector.libelle
    }
    
    func changeCandidateView(candidate: Candidate){
        candidateSeleted = candidate
        println("My candidate : \(candidate.lastName) \(candidate.firstName)")
        
        libLastName.text = candidate.lastName
        libFirstName.text = candidate.firstName
        libMail.text = candidate.mail
        
        if candidate.address == nil {
            candidate.address = "Test address, 01000, Bourg"
        }
        libAdresse.text = candidate.address
        
        if candidate.tel == nil {
            candidate.tel = "0385323136"
        }
        libTel.text = candidate.tel
        
        if candidate.mobile == nil {
            candidate.mobile = "0615203698"
        }
        libMobile.text = candidate.mobile
        
        if let photo = candidate.photo {
            let thumbnail = UIImage(data: (candidate.photo as NSData?)!)
            imgImageCandidate.image = thumbnail
        }
        
        CoreDataManager.SharedManager.saveContext()
    }
    
    // MARK: - Action Link Social Network
    @IBAction func getWebViewWithXing(sender: AnyObject) {
        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("WebViewController") as! WebViewController
        viewController.url = "https://www.xing.com/fr"
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func getWebViewWithViadeo(sender: AnyObject) {
        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("WebViewController") as! WebViewController
        viewController.url = "http://fr.viadeo.com/fr/"
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func getWebViewWithLinkedIn(sender: AnyObject) {
        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("WebViewController") as! WebViewController
        viewController.url = "https://www.linkedin.com/nhome/"
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: - Action State Candidate
    @IBAction func refuseCandidatureAction(sender: UIButton) {
        println("Candidate : \(candidateSeleted.lastName) \(candidateSeleted.firstName) is not accepted")
        
        candidateSeleted.state_candidature = StateCandidatureManager.SharedManager.getState(.RefuseCantidature)
        println("New state : \(candidateSeleted.state_candidature.libelle) \(candidateSeleted.state_candidature.color) ")
        candidateSeleted.managedObjectContext?.save(nil)
    }
    
    @IBAction func acceptCandidatureAction(sender: UIButton) {
        println("Candidate : \(candidateSeleted.lastName) \(candidateSeleted.firstName) is accepted")
        
        candidateSeleted.state_candidature = StateCandidatureManager.SharedManager.getState(.ValidateCandidature)
        println("New state : \(candidateSeleted.state_candidature.libelle) \(candidateSeleted.state_candidature.color) ")
        candidateSeleted.managedObjectContext?.save(nil)
        
        sendMailConfirm()
        
        
    }
    
    // MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println(" --numberOfRowsInSection : \(candidates.count) ")
        return candidates.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        println("CandidateViewCell")
        
        let cell = tableViewCandidate.dequeueReusableCellWithIdentifier("CandidateCell") as! CandidateViewCell
        let candidate = candidates[indexPath.row]
        
        println("Candidate : \(candidate.lastName)")
        
        cell.avatar.frame = CGRectMake(0, 0, 100, 82)
        
        cell.firstName.text  = candidate.firstName
        cell.lastName.text   = candidate.lastName
        
        let color = UIColor(rgba: candidate.state_candidature.color)
        
        cell.backgroundColor = color

        
        if let picture = candidate.photo {
            cell.avatar.image = UIImage(data: picture)
        }
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let candidate = self.candidates[indexPath.row]
        println("Candidate Selected : \(candidate.lastName) \(candidate.firstName)")
        
        changeCandidateView(candidate)
    }
    
    func sendMailConfirm(){
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

    @IBAction func clickQrCode(sender: AnyObject) {
        QRCodeViewController().configureVideoCapture()
        QRCodeViewController().addVideoPreviewLayer()
        QRCodeViewController().initializeQRView()
    }
}
