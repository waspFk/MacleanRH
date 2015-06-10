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

class CandidateViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPopoverPresentationControllerDelegate, UITableViewDelegate, UITableViewDataSource,MFMailComposeViewControllerDelegate,UISearchBarDelegate, UISearchDisplayDelegate  {
    var candidateSeleted:Candidate!
    var recruitment: Recruitment?
    var recruitments = [Recruitment]()
    var candidates:[Candidate]!
    var degrees = [Degree]()
    var filtred = [Candidate]()
    var searchActive : Bool = false
    
    @IBOutlet weak var libLastName: UITextField!
    @IBOutlet weak var libFirstName: UITextField!
    @IBOutlet weak var libMail: UITextField!
    @IBOutlet weak var libAdresse: UITextField!
    @IBOutlet weak var libTel: UITextField!
    @IBOutlet weak var libMobile: UITextField!
    @IBOutlet weak var imgImageCandidate: UIImageView!
    @IBOutlet weak var tableViewCandidate: UITableView!
    @IBOutlet weak var listCandidateTableView: UITableView!
    @IBOutlet weak var tableRecruitment: UITableView!
    @IBOutlet weak var tableDegree: UITableView!
    @IBOutlet weak var libDetailRecruitment: UITextView!
    @IBOutlet weak var libDetailDegree: UITextView!
    @IBOutlet weak var searchCandidateView: UISearchBar!
    @IBOutlet weak var searchBarCandidate: UISearchBar!
    
    var photoData: NSData!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imgImageCandidate.frame = CGRectMake(0, 0, 150, 150)
        
        initRecruitment()
        changeCandidateView(candidateSeleted)
        
        filtred = []
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
        
        if recruitment != nil
        {
            candidates = recruitment!.getCandidatesArray()
        }
        
    }
    
    func changeCandidateView(candidate: Candidate){
        candidateSeleted = candidate
        println("My candidate : \(candidate.lastName) \(candidate.firstName)")
        
        libLastName.text = candidate.lastName
        libFirstName.text = candidate.firstName
        libMail.text = candidate.mail
        
        recruitments = candidate.getRecruitmentsArray()
        degrees = candidate.getDegreesArray()
        
        tableDegree.reloadData()
        tableRecruitment.reloadData()
        
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
        
        if(searchActive == true) {
            return filtred.count
        }else if (tableView == self.listCandidateTableView) {
            return candidates.count
            
        } else if (tableView == self.tableRecruitment) {
            return recruitments.count
        }
        else {
            return degrees.count
        }

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
            if(searchActive == true){
            
                let cell = tableViewCandidate.dequeueReusableCellWithIdentifier("CandidateCell") as! CandidateViewCell
                let candidate = filtred[indexPath.row]
                
                println("Candidate : \(candidate.lastName)")
                
                cell.avatar.frame = CGRectMake(0, 0, 100, 82)
                
                cell.firstName.text  = candidate.firstName
                cell.lastName.text   = candidate.lastName
                
                let color = UIColor(rgba: candidate.state_candidature.color)
                
                cell.backgroundColor = color
                
                
                if let picture = candidate.photo {
                    cell.avatar.image = UIImage(data: picture)
                }
                
                return cell
                
            } else if (tableView == self.listCandidateTableView) {
            
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
            
            return cell
            
        } else if (tableView == self.tableRecruitment)  { // tableView == self.secondTableView
            
            
            println("tableView Recruitment")
            
            let cell = tableRecruitment.dequeueReusableCellWithIdentifier("RecruitmentCell") as! UITableViewCell
            let recruitmentCurrent = recruitments[indexPath.row]
            
            cell.textLabel?.text = recruitmentCurrent.workLibelle
            
            if recruitment != nil {
                if recruitment?.titre == recruitmentCurrent.titre {
                    let color = UIColorFromRGB(0xb3b3b3)
                    
                    cell.backgroundColor = color
                    
                    tableRecruitment.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: UITableViewScrollPosition.Middle)
                    
                    var detailFull = ""
                    let recruitment = self.recruitments[indexPath.row]
                    
                    detailFull += "Titre : \(recruitment.titre) \n"
                    detailFull += "Description : \(recruitment.workDescription!) \n"
                    
                    libDetailRecruitment.text = detailFull
                }
            }
            
            return cell
        }
        else {
            println("tableView Degree")
            
            var cell:UITableViewCell = self.tableDegree.dequeueReusableCellWithIdentifier("DegreeCell") as! UITableViewCell
            let degree = degrees[indexPath.row]
            
            cell.textLabel!.text = degree.libelle
                      
            return cell
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if (tableView == self.listCandidateTableView) {
            let candidate = self.candidates[indexPath.row]
            println("Candidate Selected : \(candidate.lastName) \(candidate.firstName)")
            
            changeCandidateView(candidate)
        }
        else if (tableView == self.tableRecruitment){
            
            var detailFull = ""
            let recruitment = self.recruitments[indexPath.row]
            
            detailFull += "Titre : \(recruitment.titre) \n"
            detailFull += "Description : \(recruitment.workDescription!) \n"
            
            libDetailRecruitment.text = detailFull
        }
        else
        {
            var detailFull = ""
            let degree = self.degrees[indexPath.row]
            
            detailFull += "Date de l'obtention du diplôme : \(degree.date!) \n"
            
            libDetailDegree.text = detailFull
        }

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

    /*@IBAction func clickQrCode(sender: AnyObject) {
        QRCodeViewController().configureVideoCapture()
        QRCodeViewController().addVideoPreviewLayer()
        QRCodeViewController().initializeQRView()
    }*/
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtred = candidates.filter({ (text) -> Bool in
            let tmp: NSString = text.lastName
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        if(filtred.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.listCandidateTableView.reloadData()
    }
    
    
}
