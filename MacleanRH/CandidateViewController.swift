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

class CandidateViewController: RootViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate, UISearchBarDelegate  {
    // MARK: - Injected variable
    var candidateSeleted:Candidate!
    var recruitmentSelected: Recruitment?
    
    // MARK: - For candidate
    var degreesCandidate :[Degree]!
    var recruitmentsCandidate:[Recruitment]!
    
    // MARK: - Listing candidate
    var candidates:[Candidate]!
    var filteredTableCandidate :[Candidate]!
    var searchActive : Bool!
    
    // MARK: - View Link
    @IBOutlet weak var searchBarCandidate: UITableView!
    
    @IBOutlet weak var tableViewCandidate: UITableView!
    @IBOutlet weak var tableViewDegree: UITableView!
    @IBOutlet weak var tableViewRecruitment: UITableView!
    
    @IBOutlet weak var avatar: UIImageView!
    
    @IBOutlet weak var textFieldDGSM: UITextField!
    @IBOutlet weak var textFieldTel: UITextField!
    @IBOutlet weak var textFieldAddress: UITextField!
    @IBOutlet weak var textFieldMail: UITextField!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldFirstName: UITextField!
    @IBOutlet weak var textFieldBirthday: UITextField!
    
    @IBOutlet weak var textAreaDegree: UITextView!
    @IBOutlet weak var textAreaRecruitment: UITextView!
    
    
    @IBOutlet weak var segmentedTypeContrat: UISegmentedControl!
    @IBOutlet weak var textFieldDateRecruitment: UITextField!
    
    override func viewDidLoad() {
        println("--viewDidLoad -- CandidateViewController")
        super.viewDidLoad()
        searchActive = false
        
        initView()
        
        loadData()
        
        changeCandidateView(candidateSeleted)
    }
    
    override func viewDidAppear(animated: Bool) {
        tableViewCandidate.reloadData()
        tableViewDegree.reloadData()
        tableViewRecruitment.reloadData()
    }
    
    // MARK: - UI Helper
    func initView() {
        avatar.frame = CGRectMake(0, 0, 150, 150)
        
        searchBarCandidate.delegate = self
        searchBarCandidate.dataSource = self
        
        tableViewCandidate.delegate = self
        tableViewCandidate.dataSource = self
        
        tableViewDegree.delegate = self
        tableViewDegree.dataSource = self
        
        tableViewRecruitment.delegate = self
        tableViewRecruitment.dataSource = self
    }
    
    func loadData(){
        println("--initRecruitment -- CandidateViewController")
        
        if let dataRecruitment = recruitmentSelected {
            candidates = dataRecruitment.getCandidatesArray()
            candidates = removeCandidateFromEmployee()
        } else {
            candidates = [Candidate]()
        }
    }
    
    func changeCandidateView(candidate: Candidate){
        println("--changeCandidateView -- CandidateViewController")
        
        candidateSeleted = candidate
        println("My candidate : \(candidate.lastName) \(candidate.firstName)")
        
        textFieldName.text = candidate.lastName
        textFieldFirstName.text = candidate.firstName
        textFieldMail.text = candidate.mail
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.ShortStyle
        textFieldBirthday.text = formatter.stringFromDate(candidate.birthday)
        
        recruitmentsCandidate = candidate.getRecruitmentsArray()
        degreesCandidate = candidate.getDegreesArray()
        
        tableViewDegree.reloadData()
        tableViewRecruitment.reloadData()
        
        if candidate.address == nil {
            candidate.address = "Test address, 01000, Bourg"
        }
        textFieldAddress.text = candidate.address
        
        if candidate.tel == nil {
            candidate.tel = "0385323136"
        }
        textFieldTel.text = candidate.tel
        
        if candidate.mobile == nil {
            candidate.mobile = "0615203698"
        }
        textFieldDGSM.text = candidate.mobile
        
        if let photo = candidate.photo {
            avatar.image = UIImage(data: (candidate.photo as NSData?)!)
        }
        
        CoreDataManager.SharedManager.saveContext()
    }
    
    func changeRecruitmentSelected(recruitment : Recruitment) {
        var detailFull = "Titre : \(recruitment.titre) \n"
        detailFull += "Description : \(recruitment.workDescription!) \n"
        
        textAreaRecruitment.text = detailFull
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.ShortStyle
        textFieldDateRecruitment.text = formatter.stringFromDate(recruitment.date)
    }
    
    // MARK: - SearchBar
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
        println("--textDidChange -- CandidateViewController : \(searchText)")
        searchActive = true;
        
        filteredTableCandidate = candidates.filter({ (text) -> Bool in
            let tmpLastName: NSString = text.lastName
            let filterLastname = tmpLastName.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            
            let tmpFirstName: NSString = text.firstName
            let filterFirstName = tmpFirstName.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            
            return (filterLastname.location != NSNotFound) || (filterFirstName.location != NSNotFound)
        })
        if(filteredTableCandidate.count > 0){
            searchActive = true;
        } else {
            searchActive = false;
        }
        self.tableViewCandidate.reloadData()
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
        
        tableViewCandidate.reloadData()
    }
    
    @IBAction func acceptCandidatureAction(sender: UIButton) {
        println("Candidate : \(candidateSeleted.lastName) \(candidateSeleted.firstName) is accepted")
        
//        candidateSeleted.state_candidature = StateCandidatureManager.SharedManager.getState(.ValidateCandidature)
//        println("New state : \(candidateSeleted.state_candidature.libelle) \(candidateSeleted.state_candidature.color) ")
//        candidateSeleted.managedObjectContext?.save(nil)
        println(segmentedTypeContrat.selectedSegmentIndex.description)
        var typeContract: TypeContract?
        switch segmentedTypeContrat.selectedSegmentIndex {
        case 0:
            typeContract = TypeContractManager.SharedManager.getTypeContract(TypeContractEnum.CDD)
        case 1:
            typeContract = TypeContractManager.SharedManager.getTypeContract(TypeContractEnum.CDI)
        default :
            println("none")
            
        }
        
        if typeContract != nil {
            let contract = ContractManager.SharedManager.createContract("\(candidateSeleted.lastName) -- \(recruitmentSelected?.workLibelle)", salary: "5000", workLibelle: recruitmentSelected!.workLibelle, typeContract: typeContract!)
            
            contract.candidate = candidateSeleted
            contract.dateStart = NSDate()
            contract.managedObjectContext?.save(nil)
        }

        
        generatePDF()
    }
    
    // MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("--numberOfRowsInSection -- CandidateViewController")
        
        switch tableView {
        case tableViewCandidate:
            if searchActive == true {
                println("--SearchActive \(filteredTableCandidate.count)")
                return filteredTableCandidate.count
            } else {
                println("--CandidateTableView \(candidates.count)")
                return candidates.count
            }
            
        case tableViewDegree:
            println("--DegreeTableView \(degreesCandidate.count)")
            return degreesCandidate.count
            
        case tableViewRecruitment:
            println("--RecruitmentTableView \(recruitmentsCandidate.count)")
            return recruitmentsCandidate.count
            
        default:
            return 0
            
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        println("--cellForRowAtIndexPath -- CandidateViewController")
        
        if tableView == tableViewCandidate {
            println("CandidateCell")
            
            let cell = tableViewCandidate.dequeueReusableCellWithIdentifier("CandidateCell") as! CandidateViewCell
            var candidate: Candidate!
            
            if searchActive == true && filteredTableCandidate.count > 0 {
                candidate = filteredTableCandidate[indexPath.row]
            } else {
                candidate = candidates[indexPath.row]
            }
            
            println("Candidate : \(candidate.lastName)")
            
            cell.avatar.frame = CGRectMake(0, 0, 100, 82)
            
            cell.firstName.text  = candidate.firstName
            cell.lastName.text   = candidate.lastName
            
            let color = UIColor(rgba: candidate.state_candidature.color)
            
            cell.backgroundColor = color
            
            if let picture = candidate.photo {
                cell.avatar.image = UIImage(data: picture)
            }
            
            println("Terminate CandidateCell searchActive")
            return cell
            
        } else if tableView == tableViewDegree {
            println("DegreeCell")
            
            let cell = self.tableViewDegree.dequeueReusableCellWithIdentifier("DegreeCell") as! UITableViewCell
            
            let degree = degreesCandidate[indexPath.row]
            cell.textLabel!.text = degree.libelle
            
            println("Terminate DegreeCell")
            return cell
            
        } else  {
            println("RecruitmentCell")
            
            let cell = tableViewRecruitment.dequeueReusableCellWithIdentifier("RecruitmentCell") as! UITableViewCell
            
            let recruitmentCurrent = recruitmentsCandidate[indexPath.row]
            cell.textLabel?.text = recruitmentCurrent.workLibelle
            
            if let recruitment = recruitmentSelected {
                if recruitment.titre == recruitmentCurrent.titre {
                    cell.backgroundColor = UIColor(rgba: "#E82C0C")
                    
                    //tableViewRecruitment.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: UITableViewScrollPosition.Middle)
                    changeRecruitmentSelected(self.recruitmentsCandidate[indexPath.row])
                }
            }
            
            println("Terminate RecruitmentCell")
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("--didSelectRowAtIndexPath -- CandidateViewController")
        
        if (tableView == self.tableViewCandidate) {
            println("Candidate seleted row \(indexPath.row)")
            var candidate :Candidate!

            println("Value searchActive = \(searchActive)")
            if searchActive == true && indexPath.row < filteredTableCandidate.count {
                println("-- searchActive")
                candidate = self.filteredTableCandidate[indexPath.row]
            } else {
                println("-- candidate")
                candidate = self.candidates[indexPath.row]
            }
            
            println("Candidate Selected : \(candidate.lastName) \(candidate.firstName)")
            changeCandidateView(candidate)
            
        } else if (tableView == self.tableViewRecruitment){
            println("Recruitment seleted row \(indexPath.row)")
            changeRecruitmentSelected(self.recruitmentsCandidate[indexPath.row])
            
        } else {
            println("Degree seleted row \(indexPath.row)")
            let degree = self.degreesCandidate[indexPath.row]
            
            let formatter = NSDateFormatter()
            formatter.dateStyle = NSDateFormatterStyle.ShortStyle
            textAreaDegree.text = "Date de l'obtention du diplôme : \(formatter.stringFromDate(degree.date!)) \n"
            
        }
    }

    func generatePDF() {
        
        println("--didSelectRowAtIndexPath -- CandidateViewController")
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let date = NSDate()
        let str = "contract-\(date)-\(candidateSeleted.firstName)_\(candidateSeleted.lastName).pdf"
        let path = documentsDirectory.stringByAppendingPathComponent(str)
        var html: String?
        
        println(segmentedTypeContrat.selectedSegmentIndex)
        if segmentedTypeContrat.selectedSegmentIndex == 0 {
            html = "<h1>Contrat à Durée Déterminée</h1><p>Entre les soussignés :</p><p>La Société Maclean, située ..., immatriculée au Registre du Commerce et des Sociétés de ... sous le numéro 987654321, représentée par ..., agissant en sa qualité de prestataire de services,</p><p>D'une part,</p><p>Et :</p><p>Mlle/Mme/Mr \(candidateSeleted.lastName) \(candidateSeleted.firstName), de nationalité ...,</p><p>Né(e) le \(candidateSeleted.birthday) à ..., demeurant \(candidateSeleted.address!),</p><p>D'autre part,</p><p>Il est arrêté et convenu ce qui suit :</p></br><h2>Article 1 : Engagement</h2><p>Vous êtes engagé(e) à compter du ... au sein de la société Maclean, sous réserve du résultat favorable de la visite médicale d'embauche.</p><h2>Article 2 : Fonctions exercées</h2><p>Vous exercerez les fonctions de \(recruitmentSelected!.workLibelle), statut \(recruitmentSelected!.sector.libelle).</p><p>Vous vous engagez à vous conformer aux dispositions conventionnelles en vigueur dans la société Maclean. Actuellement, est applicable la Convention Collective n°123456789.</p><h2>Article 3 : Lieu de travail et clause de mobilité</h2><p>Votre lieu de travail sera le siège de la société, actuellement situé .... Ce lieu de travail ou le service auquel vous êtes affecté(e) pourra être modifié en fonction des évolutions internes de l’entreprise. Les délais de prévenance pour ces éventuelles modifications respecteront les dispositions légales.</p><p>A ce titre, vous acceptez tout changement de lieu de travail dans la région Ile de France.</p><h2>Article 4 : Durée du contrat et période d'essai</h2><p>Le présent contrat est conclu pour une durée déterminée, du ... au ... pour ....</p><p>Les ... premiers jours de son exécution soit du ... au ..., constituent une période d'essai, au cours de laquelle chacune des parties pourra mettre fin sans indemnité d'aucune sorte, à charge pour la partie qui rompt la période d’essai de respecter les dispositions légales et conventionnelles.</p><h2>Article 5 : Rémunération</h2><p>Votre rémunération annuelle brute est fixée à ... euros, soit une rémunération versée en douze mensualités d’un montant forfaitaire brut de ... euros.</p><p>Cette rémunération revêt un caractère forfaitaire et prend en considération tout dépassement que vous serez amenée à réaliser à votre initiative.</p><h2>Article 6 : Durée du travail</h2><p>En fonction de l’accord de l’entreprise.</p><h2>Article 7 : Remboursement de frais</h2><p>La société remboursera au salarié les frais engagés par le salarié dans le cadre de l'exercice de ses fonctions, sur présentation des justificatifs et conformément à la procédure de remboursement de frais applicable dans l'entreprise.</p><h2>Article 8 : Congés payés</h2><p>Vous bénéficierez des congés payés et, en l’absence d’accord commun, la date de vos congés payés sera déterminée par la société.</p><h2>Article 9 : Protection sociale</h2><p>Vous cotiserez aux différents régimes de retraite et de prévoyance en vigueur au sein de notre Société.</p><h2>Article 10 : Règlement Intérieur et Charte Informatique</h2><p>Les parties s’engagent à respecter les dispositions légales, réglementaires et conventionnelles en vigueur dans l’entreprise et le salarié déclare avoir pris connaissance du Règlement Intérieur.</p><p>Vous vous engagez également à accepter les modalités de la Charte informatique, dont un exemplaire est porté à votre connaissance au moment de votre arrivée.</p><h2>Article 11 : Clause de confidentialité</h2><p>Vous vous engagez à observer la discrétion la plus stricte sur les informations se rapportant aux activités de la société auxquelles vous aurez accès à l’occasion et dans le cadre de vos fonctions.</p><p>Notamment, vous ne divulguerez à quiconque les méthodes, recommandations, créations, devis, études, projets, savoir-faire de l’entreprise résultant de travaux réalisés dans l’entreprise qui sont couverts par le secret professionnel le plus strict. Vous serez lié(e) par la même obligation vis-à-vis de tout renseignement ou document dont vous aurez pris connaissance chez des clients de la société.</p><p>Tous les documents, lettres, notes de service, instructions, méthodes, organisation et/ou fonctionnement de l’entreprise dont vous pourrez avoir connaissance dans l’exercice de vos fonctions, seront confidentiels et resteront la propriété exclusive de la Société.</p><p>Vous ne pourrez, sans accord écrit de la direction, publier aucune étude sous quelque forme que ce soit portant sur des travaux ou des informations couverts par l’obligation de confidentialité. Cette obligation de confidentialité se prolongera après la cessation du contrat de travail, quelle qu’en soit la cause.</p><h2>Article 12 : Obligation de fidélité</h2><p>Pendant la durée du présent contrat, vous prenez l’engagement de ne participer, sous quelque forme que ce soit, à aucune activité susceptible de concurrencer en tout ou partie celle de la société qui vous emploie.</p><h2>Article 13 : Propriété Intellectuelle</h2><p>Dans le cadre de votre activité professionnelle, vous serez amené(e) à participer, au coté d’autres collaborateurs, et sous la direction et le contrôle de votre employeur à l'élaboration de diverses œuvres protégées par le droit de la propriété intellectuelle (notamment sites Internet, éléments d'ergonomie, architecture, illustrations, photographies, graphismes, sons, vidéos, icônes, logos, éléments de design, textes, structures de bases de données, etc.).</p><p>En raison des investissements qui seront réalisés par la Société dans le cadre de l’élaboration et de l’édition de ces œuvres, et compte tenu de la contribution collective des participants, vous reconnaissez expressément que ces œuvres seront soumises au régime des œuvres collectives, dont la Société ... sera le titulaire exclusif des droits moraux et patrimoniaux conformément aux articles L113-2 et suivants du Code de la propriété intellectuelle et plus particulièrement de l’article 113-5.</p><p>Les droits de propriété intellectuelle afférents aux logiciels (notamment codes-source et codes-objet) et à leur documentation, que vous pourrez être amené(e) à créer dans le cadre de votre activité professionnelle seront dévolus à la Société ..., qui sera seule habilitée à les exercer, conformément à l'article L. 113-9 du Code de la Propriété Intellectuelle.</p><h2>Article 14 : Droit à l'image</h2><p>Vous autorisez la société ... à utiliser votre photo pour un usage strictement interne.</p><h2>Article 15 : Modifications des informations personnelles</h2><p>Vous vous engagez à informer la société dans les meilleurs délais de tout changement de votre situation personnelle (adresse, nombre de personnes à charge…). Cette base d’informations est transmise au Comité d’Entreprise et lui permet d’attribuer d’éventuels avantages conditionnés à ses critères.</p><p>Votre accord implique formellement que vous n'êtes lié(e) à aucune autre entreprise et que vous avez quitté votre précédent employeur libre de tout engagement. Vous vous engagez à consacrer toute votre activité professionnelle au service de la société.</p></br><p>Vous voudrez bien nous confirmer votre accord en apposant votre signature précédée de la mention manuscrite 'lu et approuvé' sur la dernière page, les pages précédentes étant également à parapher par vos soins.</p></br><p>Nous vous prions de croire, ..., à l'expression de nos salutations distinguées.</p></br><p>Fait en deux originaux,</br>A ..., le ....</p><p>Le signataire,</p>"
        }
        else {
            html = "<h1>Contrat à Durée Indéterminée</h1><p>Entre les soussignés :</p><p>La Société Maclean, située ..., immatriculée au Registre du Commerce et des Sociétés de ... sous le numéro 987654321, représentée par ..., agissant en sa qualité de prestataire de services,</p><p>D'une part,</p><p>Et :</p><p>Mlle/Mme/Mr \(candidateSeleted.lastName) \(candidateSeleted.firstName), de nationalité ...,</p><p>Né(e) le \(candidateSeleted.birthday) à ..., demeurant \(candidateSeleted.address),</p><p>D'autre part,</p><p>Il est arrêté et convenu ce qui suit :</p></br><h2>Article 1 : Engagement</h2><p>Vous êtes engagé(e) à compter du ... au sein de la société Maclean, sous réserve du résultat favorable de la visite médicale d'embauche.<p><h2>Article 2 : Fonctions exercées</h2><p>Vous exercerez les fonctions de \(recruitmentSelected!.workLibelle), statut \(recruitmentSelected!.sector.libelle).</p><p>Vous vous engagez à vous conformer aux dispositions conventionnelles en vigueur dans la société Maclean. Actuellement, est applicables la Convention Collective n°123456789</p><h2>Article 3 : Lieu de travail et clause de mobilité</h2><p>Votre lieu de travail sera le siège de la société, actuellement situé ....</p><p>Ce lieu de travail ou le service auquel vous êtes affecté(e) pourra être modifié en fonction des évolutions internes de l'entreprise. Les délais de prévenance pour ces éventuelles modifications respecteront les dispositions légales.</p><p>A ce titre, vous acceptez tout changement de lieu de travail dans la région ....</p><p>Les 4 premiers mois de son exécution constituent une période d'essai pour les cadres ou les 2 premiers mois de période d'essai pour les non cadres, au cours de laquelle chacune des parties pourra mettre fin sans indemnité d'aucune sorte, à charge pour la partie qui rompt la période d'essai de respecter les dispositions légales et conventionnelles. Cette période d'essai pourra être prolongée exceptionnellement d'une période de même durée.</p><h2>Article 5 : Rémunération</h2><p>Votre rémunération annuelle brute est fixée à ... euros, soit une rémunération versée en douze mensualités d'un montant forfaitaire brut de ... euros.</p><p>Cette rémunération revêt un caractère forfaitaire et prend en considération tout dépassement que vou serez amené(e) à réaliser à votre initiative.</p><h2>Article 6 : Durée du travail</h2><p>En fonction de l'accord de l'entreprise.</p><h2>Article 7 : Remboursement de frais</h2><p>La société remboursera au salarié les frais engagés par le salarié dans le cadre de l'exercice de ses fonctions, sur présentation des justificatifs et conformément à la procédure de remboursement de frais applicable dans l'entreprise.</p><h2>Article 8 : Congés payés</h2><p>Vous bénéficierez des congés payés et en l'absence d'accord commun, la date de vos congés payés sera déterminée par la Société.</p><h2>Article 9 : Protection sociale</h2><p>Vous cotiserez aux différents régimes de retraite et de prévoyance en vigueur au sein de notre Société.</p><h2>Article 10 : Réglement intérieur et Charte informatique</h2><p>(En fonction des entreprises). Les parties s’engagent à respecter les dispositions légales, réglementaires et conventionnelles en vigueur dans l’entreprise et le salarié déclare avoir pris connaissance du Règlement Intérieur.</p><p>Vous vous engagez également à accepter les modalités de la Charte informatique, dont un exemplaire est porté à votre connaissance au moment de votre arrivée.</p><h2>Article 11 : Clause de confidentialité</h2><p>Vous vous engagez à observer la discrétion la plus stricte sur les informations se rapportant aux activités de la société auxquelles vous aurez accès à l’occasion et dans le cadre de vos fonctions.</p><p>Notamment, vous ne divulguerez à quiconque les méthodes, recommandations, créations, devis, études, projets, savoir-faire de l’entreprise résultant de travaux réalisés dans l’entreprise qui sont couverts par le secret professionnel le plus strict. Vous serez lié (e) par la même obligation vis-à-vis de tout renseignement ou document dont vous aurez pris connaissance chez des clients de la société.</p><p>Tous les documents, lettres, notes de service, instructions, méthodes, organisation et/ou fonctionnement de l’entreprise dont vous pourrez avoir connaissance dans l’exercice de vos fonctions, seront confidentiels et resteront la propriété exclusive de la Société.</p><p>Vous ne pourrez, sans accord écrit de la direction, publier aucune étude sous quelque forme que ce soit portant sur des travaux ou des informations couverts par l’obligation de confidentialité. Cette obligation de confidentialité se prolongera après la cessation du contrat de travail, quelle qu’en soit la cause.</p><h2>Article 12 : Obligation de fidélité</h2><p>Pendant la durée du présent contrat, vous prenez l’engagement de ne participer, sous quelque forme que ce soit, à aucune activité susceptible de concurrencer en tout ou partie celle de la société qui vous emploie.</p><h2>Article 13 : Propriété Intellectuelle</h2><p>Dans le cadre de votre activité professionnelle, vous serez amené (e) à participer, au coté d’autres collaborateurs, et sous la direction et le contrôle de votre employeur à l'élaboration de diverses œuvres protégées par le droit de la propriété intellectuelle (notamment sites Internet, éléments d'ergonomie, architecture, illustrations, photographies, graphismes, sons, vidéos, icônes, logos, éléments de design, textes, structures de bases de données, etc.)</p><p>En raison des investissements qui seront réalisés par la Société dans le cadre de l’élaboration et de l’édition de ces œuvres, et compte tenu de la contribution collective des participants, vous reconnaissez expressément que ces œuvres seront soumises au régime des œuvres collectives, dont la Société Maclean sera le titulaire exclusif des droits moraux et patrimoniaux conformément aux articles L113-2 et suivants du Code de la propriété intellectuelle et plus particulièrement de l’article 113-5.</p><p>Les droits de propriété intellectuelle afférents aux logiciels (notamment codes-source et codes-objet) et à leur documentation, que vous pourrez être amené (e) à créer dans le cadre de votre activité professionnelle seront dévolus à la Société ..., qui sera seule habilitée à les exercer, conformément à l'article L. 113-9 du Code de la Propriété Intellectuelle.</p><h2>Article 14 : Droit à l'image</h2><p>Vous autorisez la société Maclean à utiliser votre photo pour un usage strictement interne.</p><h2>Article 15 : Résiliation</h2><p>Sauf licenciement pour faute grave ou lourde, le contrat pourra être résilié, par l’une ou l’autre des parties, moyennant un délai-congé dont la durée est fixée par la convention collective en fonction du statut et de l’ancienneté dans l’entreprise.</p><h2>Article 16 : Modifications des informations personnelles</h2><p>Vous vous engagez à informer la société dans les meilleurs délais de tout changement de votre situation personnelle (adresse, nombre de personnes à charge…). Cette base d’informations est transmise au Comité d’Entreprise et lui permet d’attribuer d’éventuels avantages conditionnés à ses critères.</p><p>Votre accord implique formellement que vous n'êtes lié (e) à aucune autre entreprise et que vous avez quitté votre précédent employeur libre de tout engagement. Vous vous engagez à consacrer toute votre activité professionnelle au service de la société.</p></br><p>Vous voudrez bien nous confirmer votre accord en apposant votre signature précédée de la mention manuscrite 'lu et approuvé' sur la dernière page, les pages précédentes étant également à parapher par vos soins.</p></br><p>Nous vous prions de croire, ... , à l'expression de nos salutations distinguées.</p></br><p>Fait en deux originaux,</br>A ..., le ....</p><p>Le signataire,</p>"
        }
        
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
        
        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("ContractViewController") as! ContractViewController
        viewController.url = path
        viewController.name = str
        viewController.candidate = candidateSeleted
        self.presentViewController(viewController, animated: true, completion: nil)
    }
    
    func removeCandidateFromEmployee() -> [Candidate] {
        var tmpCandidates = [Candidate]()
        
        for candidate in candidates {
            if (EmployeeManager.SharedManager.searchEmployeeWithMail(candidate.mail) == nil)
            {
                tmpCandidates.append(candidate)
            }
        }
        
        return tmpCandidates
    }
}
