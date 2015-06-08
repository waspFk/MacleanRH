//
//  CandidateViewController.swift
//  MacleanRH
//
//  Created by iem on 04/06/2015.
//  Copyright (c) 2015 iem. All rights reserved.
//

import UIKit

class CandidateViewController: UIViewController
{
    var candidate:Candidate!
    @IBOutlet weak var libLastName: UITextField!
    @IBOutlet weak var libFirstName: UITextField!
    @IBOutlet weak var libMail: UITextField!
    @IBOutlet weak var libAdresse: UITextField!
    @IBOutlet weak var libTel: UITextField!
    @IBOutlet weak var libMobile: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("My candidate : \(candidate.lastName) \(candidate.firstName)")
        
        //let candidates = CandidateManager.SharedManager.getAllCandidates("lastName")
        
        /*let recruitment = RecruitmentManager.SharedManager.createRecruitment("Nouveau poste", workLibelle: "Informatique", workDescription: "Administrateur réseau", date: NSDate())*/

        //CandidateManager.SharedManager.createCandidate("Meunier", firstname: "Cyril", mail: "cyril.meunier71@gmail.com",address: "19 impasse du tilleul \n 71960\n Milly-Lamartine",tel: "0610203645",mobile: "0385331460")

        //let candidate = CandidateManager.SharedManager.searchCandidateWithMail("cyril.meunier71@gmail.com")
        
        /*candidate?.candidate_recruitment.setByAddingObject(recruitment)
        candidate?.managedObjectContext?.save(nil)*/
        
        libLastName.text = candidate!.lastName
        libFirstName.text = candidate!.firstName
        libMail.text = candidate?.mail
        libAdresse.text = candidate?.address
        libTel.text = candidate?.tel
        libMobile.text = candidate?.mobile
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
        /*let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("WebViewController") as! WebViewController
        viewController.url = "https://www.linkedin.com/nhome/"
        self.navigationController?.pushViewController(viewController, animated: true)*/
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent("test_test.pdf")
        
        var html = "<h1>Hello world !</h1></br>"
        html += "<h2>! dlrow olleH</h2></br>"
        html += "<p>testtesttesttesttesttesttesttesttesttesttesttesttest</p>"
        html += "<p>testtesttesttesttesttesttesttesttesttesttesttesttest</p>"
        html += "<p>testtesttesttesttesttesttesttesttesttesttesttesttest</p>"
        html += "<p>testtesttesttesttesttesttesttesttesttesttesttesttest</p>"
        html += "<p>testtesttesttesttesttesttesttesttesttesttesttesttest</p>"
        html += "<p>testtesttesttesttesttesttesttesttesttesttesttesttest</p>"
        html += "<p>testtesttesttesttesttesttesttesttesttesttesttesttest</p>"
        let fmt = UIMarkupTextPrintFormatter(markupText: html)
        
        let render = UIPrintPageRenderer()
        render.addPrintFormatter(fmt, startingAtPageAtIndex: 0)
        
        let page = CGRect(x: 0, y: 0, width: 595.2, height: 841.8)
        let printable = CGRectInset(page, 0, 0)
        
        render.setValue(NSValue(CGRect: page), forKey: "paperRect")
        render.setValue(NSValue(CGRect: printable), forKey: "printableRect")
        
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, CGRectZero, nil)
        
        for i in 1...render.numberOfPages() {
            
            UIGraphicsBeginPDFPage();
            let bounds = UIGraphicsGetPDFContextBounds()
            render.drawPageAtIndex(i - 1, inRect: bounds)
        }
        
        UIGraphicsEndPDFContext();
        
        println("pdfData.length : ")
        println(pdfData.length)
        
        pdfData.writeToFile(path, atomically: true)
        
        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("WebViewController") as! WebViewController
        viewController.url = path
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
