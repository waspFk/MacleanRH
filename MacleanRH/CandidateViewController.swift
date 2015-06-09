//
//  CandidateViewController.swift
//  MacleanRH
//
//  Created by iem on 04/06/2015.
//  Copyright (c) 2015 iem. All rights reserved.
//

import UIKit

class CandidateViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPopoverPresentationControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    var candidate:Candidate!
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
        
        println("My candidate : \(candidate.lastName) \(candidate.firstName)")
        
        candidates = recruitment.getCandidatesArray()
        
        candidate.address = "Test address, 01000, Bourg"
        candidate.tel = "0385323136"
        candidate.mobile = "0615203698"
        candidate.photo = UIImageJPEGRepresentation(UIImage(named: "noimage.png"), 160.0)
        candidate.managedObjectContext?.save(nil)
        
        imgImageCandidate.frame = CGRectMake(0, 0, 200, 200)
        let thumbnail = UIImage(data: (candidate.photo as NSData?)!)
        imgImageCandidate.image = thumbnail
    
        libLastName.text = candidate.lastName
        libFirstName.text = candidate.firstName
        libMail.text = candidate.mail
        
        if let data = candidate.address {
            libAdresse.text = data
        }
        
        if let data = candidate.tel {
            libTel.text = data
        }
        
        if let data = candidate.mobile {
            libMobile.text = data
        }
        

        libPoste.text = recruitment.workLibelle
        libSector.text = recruitment.sector.libelle
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage
        image: UIImage!,
        editingInfo: [NSObject : AnyObject]!) {
            
            self.imgImageCandidate.image = image
            self.dismissViewControllerAnimated(true, completion: nil)
            
            photoData = UIImageJPEGRepresentation(image, 100)
    }
    
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
        
        cell.firstName.text  = candidate.firstName
        cell.lastName.text   = candidate.lastName
        
        if let picture = candidate.photo {
            cell.avatar.image = UIImage(data: picture)
        }
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }

}
