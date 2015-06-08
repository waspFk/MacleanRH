//
//  CandidateViewController.swift
//  MacleanRH
//
//  Created by iem on 04/06/2015.
//  Copyright (c) 2015 iem. All rights reserved.
//

import UIKit

class CandidateViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIPopoverPresentationControllerDelegate
{
    var candidate:Candidate!
    var recruitment: Recruitment!
    

    
    @IBOutlet weak var libLastName: UITextField!
    @IBOutlet weak var libFirstName: UITextField!
    @IBOutlet weak var libMail: UITextField!
    @IBOutlet weak var libAdresse: UITextField!
    @IBOutlet weak var libTel: UITextField!
    @IBOutlet weak var libMobile: UITextField!
    @IBOutlet weak var libPoste: UITextField!
    @IBOutlet weak var imgImageCandidate: UIImageView!
    @IBOutlet weak var libSector: UITextField!
    
    var photoData: NSData!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("My candidate : \(candidate.lastName) \(candidate.firstName)")
        
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
        
        if let data = candidate?.address {
            libAdresse.text = data
        }
        
        if let data = candidate?.tel {
            libTel.text = data
        }
        
        if let data = candidate?.mobile {
            libMobile.text = data
        }
        
        if let data = recruitment?.workLibelle {
            libPoste.text = data
        }
        
        if let data = recruitment?.sector?.libelle {
            libSector.text = data
        }
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage
        image: UIImage!,
        editingInfo: [NSObject : AnyObject]!) {
            
            self.imgImageCandidate.image = image
            self.dismissViewControllerAnimated(true, completion: nil)
            
            photoData = UIImageJPEGRepresentation(image, 100)
    }
}
