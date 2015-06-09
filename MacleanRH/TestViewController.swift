//
//  TestViewController.swift
//  MacleanRH
//
//  Created by iem on 02/06/2015.
//  Copyright (c) 2015 iem. All rights reserved.
//

import UIKit
import AVFoundation
import EventKit
import MessageUI

class TestViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var txtData: UITextField!
    @IBOutlet weak var imgQrCode: UIImageView!
    @IBOutlet weak var libQrCode: UILabel!
    
    var objCaptureSession:AVCaptureSession?
    var objCaptureVideoPreviewLayer:AVCaptureVideoPreviewLayer?
    var vwQRCode:UIView?
    
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
//        RecruitmentManager.SharedManager.createRecruitment("Test recruitment 1",workLibelle: "Work test libellé",workDescription: "Work test description",date: NSDate())
//        RecruitmentManager.SharedManager.createRecruitment("Test recruitment 2",workLibelle: "Work test libellé",workDescription: "Work test description",date: NSDate())
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
            println(contractVal.libelle!+" -- "+contractVal.typeContract!.libelle)
        }
        
        println(" ---- Search Test ---- ")
        contract = ContractManager.SharedManager.searchContract("libelle",data: "Contract 2")!
        println(contract.libelle!+" -- "+contract.typeContract!.libelle)
        
        
        println(" ---- Delete Test ---- ")
        ContractManager.SharedManager.deleteContract(contract)
        
        contracts = ContractManager.SharedManager.getAllContracts(nil)
        
        for contractVal in contracts
        {
            println(contractVal.libelle!+" -- "+contractVal.typeContract!.libelle)
        }
    }
    
    @IBAction func btnGenerate(sender: AnyObject) {
        var qrCode: CIImage
        
        let data = txtData.text.dataUsingEncoding(NSISOLatin1StringEncoding,allowLossyConversion: false)
        
        let filter = CIFilter(name: "CIQRCodeGenerator")
        
        filter.setValue(data, forKey: "inputMessage")
        
        qrCode = filter.outputImage
        
        imgQrCode.image = UIImage(CIImage: qrCode)
        
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
    
    func fetchEvents(store: EKEventStore) -> NSMutableArray{
        let endDate = NSDate(timeIntervalSinceNow: 604800*10);
        let predicate = store.predicateForEventsWithStartDate(NSDate(), endDate: NSDate(), calendars: nil)
        let events = NSMutableArray(array: store.eventsMatchingPredicate(predicate))
        return events
    }
    
    // MARK: Contract genrated PDF
    
    func generatePDF() {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent("test_test.pdf")
        
        var html = "<h1>Contrat à Durée Indéterminée</h1><h2>Article 1 : Engagement</h2><p>Vous êtes engagé(e) à compter du au sein de la société, sous réserve du résultat favorable de la visite médicale d'embauche.<p><h2>Article 2 : Fonctions exercées</h2><p>Vous exercerez les fonctions de ..., statut ..., niveau ..., coefficient ....</p><p>Vous vous engagez à vous conformer aux dispositions conventionnelles en vigueur dans la société .... Actuellement, est applicables la Convention Collective n°....</p><h2>Article 3 : Lieu de travail et clause de mobilité</h2><p>Votre lieu de travail sera le siège de la société, actuellement situé ....</p><p>Ce lieu de travail ou le service auquel vous êtes affecté(e) pourra être modifié en fonction des évolutions internes de l'entreprise. Les délais de prévenance pour ces éventuelles modifications respecteront les dispositions légales.</p><p>A ce titre, vous acceptez tout changement de lieu de travail dans la région ....</p><p>Les 4 premiers mois de son exécution constituent une période d'essai pour les cadres ou les 2 premiers mois de période d'essai pour les non cadres, au cours de laquelle chacune des parties pourra mettre fin sans indemnité d'aucune sorte, à charge pour la partie qui rompt la période d'essai de respecter les dispositions légales et conventionnelles. Cette période d'essai pourra être prolongée exceptionnellement d'une période de même durée.</p><h2>Article 5 : Rémunération</h2><p>Votre rémunération annuelle brute est fixée à ... € (... euros), soit une rémunération versée en douze mensualités d'un montant forfaitaire brut de ... € (... euros).</p><p>Cette rémunération revêt un caractère forfaitaire et prend en considération tout dépassement que vou serez amené(e) à réaliser à votre initiative.</p><h2>Article 6 : Durée du travail</h2><p>En fonction de l'accord de l'entreprise.</p><h2>Article 7 : Remboursement de frais</h2><p>La société remboursera au salarié les frais engagés par le salarié dans le cadre de l'exercice de ses fonctions, sur présentation des justificatifs et conformément à la procédure de remboursement de frais applicable dans l'entreprise.</p><h2>Article 8 : Congés payés</h2><p>Vous bénéficierez des congés payés et en l'absence d'accord commun, la date de vos congés payés sera déterminée par la Société.</p><h2>Article 9 : Protection sociale</h2><p>Vous cotiserez aux différents régimes de retraite et de prévoyance en vigueur au sein de notre Société.</p><h2>Article 10 : Réglement intérieur et Charte informatique</h2><p>(En fonction des entreprises). Les parties s’engagent à respecter les dispositions légales, réglementaires et conventionnelles en vigueur dans l’entreprise et le salarié déclare avoir pris connaissance du Règlement Intérieur.</p><p>Vous vous engagez également à accepter les modalités de la Charte informatique, dont un exemplaire est porté à votre connaissance au moment de votre arrivée.</p><h2>Article 11 : Clause de confidentialité</h2><p>Vous vous engagez à observer la discrétion la plus stricte sur les informations se rapportant aux activités de la société auxquelles vous aurez accès à l’occasion et dans le cadre de vos fonctions.</p><p>Notamment, vous ne divulguerez à quiconque les méthodes, recommandations, créations, devis, études, projets, savoir-faire de l’entreprise résultant de travaux réalisés dans l’entreprise qui sont couverts par le secret professionnel le plus strict. Vous serez lié (e) par la même obligation vis-à-vis de tout renseignement ou document dont vous aurez pris connaissance chez des clients de la société.</p><p>Tous les documents, lettres, notes de service, instructions, méthodes, organisation et/ou fonctionnement de l’entreprise dont vous pourrez avoir connaissance dans l’exercice de vos fonctions, seront confidentiels et resteront la propriété exclusive de la Société.</p><p>Vous ne pourrez, sans accord écrit de la direction, publier aucune étude sous quelque forme que ce soit portant sur des travaux ou des informations couverts par l’obligation de confidentialité. Cette obligation de confidentialité se prolongera après la cessation du contrat de travail, quelle qu’en soit la cause.</p><h2>Article 12 : Obligation de fidélité</h2><p>Pendant la durée du présent contrat, vous prenez l’engagement de ne participer, sous quelque forme que ce soit, à aucune activité susceptible de concurrencer en tout ou partie celle de la société qui vous emploie.</p><h2>Article 13 : Propriété Intellectuelle</h2><p>Dans le cadre de votre activité professionnelle, vous serez amené (e) à participer, au coté d’autres collaborateurs, et sous la direction et le contrôle de votre employeur à l'élaboration de diverses œuvres protégées par le droit de la propriété intellectuelle (notamment sites Internet, éléments d'ergonomie, architecture, illustrations, photographies, graphismes, sons, vidéos, icônes, logos, éléments de design, textes, structures de bases de données, etc.)</p><p>En raison des investissements qui seront réalisés par la Société dans le cadre de l’élaboration et de l’édition de ces œuvres, et compte tenu de la contribution collective des participants, vous reconnaissez expressément que ces œuvres seront soumises au régime des œuvres collectives, dont la Société ... sera le titulaire exclusif des droits moraux et patrimoniaux conformément aux articles L113-2 et suivants du Code de la propriété intellectuelle et plus particulièrement de l’article 113-5.</p><p>Les droits de propriété intellectuelle afférents aux logiciels (notamment codes-source et codes-objet) et à leur documentation, que vous pourrez être amené (e) à créer dans le cadre de votre activité professionnelle seront dévolus à la Société ..., qui sera seule habilitée à les exercer, conformément à l'article L. 113-9 du Code de la Propriété Intellectuelle.</p><h2>Article 14 : Droit à l'image</h2><p>Vous autorisez la société ... à utiliser votre photo pour un usage strictement interne.</p><h2>Article 15 : Résiliation</h2><p>Sauf licenciement pour faute grave ou lourde, le contrat pourra être résilié, par l’une ou l’autre des parties, moyennant un délai-congé dont la durée est fixée par la convention collective en fonction du statut et de l’ancienneté dans l’entreprise.</p><h2>Article 16 : Modifications des informations personnelles</h2><p>Vous vous engagez à informer la société dans les meilleurs délais de tout changement de votre situation personnelle (adresse, nombre de personnes à charge…). Cette base d’informations est transmise au Comité d’Entreprise et lui permet d’attribuer d’éventuels avantages conditionnés à ses critères.</p><p>Votre accord implique formellement que vous n'êtes lié (e) à aucune autre entreprise et que vous avez quitté votre précédent employeur libre de tout engagement. Vous vous engagez à consacrer toute votre activité professionnelle au service de la société.</p><p>Vous voudrez bien nous confirmer votre accord en apposant votre signature précédée de la mention manuscrite 'lu et approuvé' sur la dernière page, les pages précédentes étant également à parapher par vos soins.</p></br><p>Nous vous prions de croire, ..., à l'expression de nos salutations distinguées.</p></br><p>Fait en deux originaux,</br>A ..., le ...,</p><p>Le signataire</p>"
        
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
        
        pdfData.writeToFile(path, atomically: true)
        
        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("WebViewController") as! WebViewController
        viewController.url = path
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

