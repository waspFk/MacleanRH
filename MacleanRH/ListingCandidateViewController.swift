//
//  ListingCandidateViewController.swift
//  MacleanRH
//
//  Created by iem on 04/06/2015.
//  Copyright (c) 2015 iem. All rights reserved.
//

import UIKit

class ListingCandidateViewController: RootViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    var candidates:[Candidate]!
    var recruitment:Recruitment!
    
    var filteredTableCandidate:[Candidate]!
    var searchBarActive :Bool!

    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBarActive = false
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        filteredTableCandidate = [Candidate]()
        
        loadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - SearchBar
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        println(" --searchBarTextDidEndEditing")
        searchBarActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        println(" --searchBarCancelButtonClicked")
        searchBarActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        println(" --searchBarSearchButtonClicked")
        searchBarActive = false;
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        println(" --textDidChange")
        
        self.filteredTableCandidate = self.candidates.filter(
            {
                ( candidate: Candidate) -> Bool in
                println("SearhText = \(searchText)")
                
                let tmpLastName: NSString = candidate.lastName
                let filterLastname = tmpLastName.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
                println("Filter LastName = \(filterLastname)")
                
                let tmpFirstName: NSString = candidate.firstName
                let filterFirstName = tmpFirstName.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
                println("Filter FirstName = \(filterFirstName)")
                
                let tmpMail: NSString = candidate.mail
                let filterMail = tmpMail.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
                println("Filter Mail = \(filterMail)")
                
                return (filterLastname.location != NSNotFound) || (filterFirstName.location != NSNotFound) || (filterMail.location != NSNotFound)
            }
        )
        
        println("Number element filteredTableCandidate = \(filteredTableCandidate.count)")
        
        if(filteredTableCandidate.count == 0){
            searchBarActive = false;
        } else {
            searchBarActive = true;
        }
        
        self.tableView.reloadData()
    }
    
    // MARK: - Helper UI
    func loadData() {
        candidates = recruitment.getCandidatesArray()
        candidates = removeCandidateFromEmployee()
        println("Count candidates = \(candidates.count)")
    }
    
    
    // MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchBarActive  == true){
            return filteredTableCandidate.count
        }
        return candidates.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("CandidateCell") as! CandidateViewCell
        var candidate :Candidate!
        
        if(searchBarActive  == true){
            candidate = filteredTableCandidate[indexPath.row]
        } else {
            candidate = candidates[indexPath.row]
        }
        
        println("Found Candidate : \(candidate.lastName) \(candidate.firstName)")
        
        cell.firstName.text  = candidate.firstName
        cell.lastName.text   = candidate.lastName
        
        println("Color Candidate : \(candidate.state_candidature.color)")
        
        let color = UIColor(rgba: candidate.state_candidature.color)
        println(println("Color UI : \(color.description)"))
        
        cell.backgroundColor = color
        
        if let picture = candidate.photo {
            cell.avatar.image = UIImage(data: picture)
        }
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        println("prepareForSegue")
        if segue.identifier == "CandidateViewSegue" {
            if let destination = segue.destinationViewController as? CandidateViewController {
                if let index = tableView.indexPathForSelectedRow()?.row {
                    if(searchBarActive  == true){
                        destination.candidateSeleted = filteredTableCandidate[index]
                    } else {
                        destination.candidateSeleted = candidates[index]
                    }
                    
                    destination.recruitmentSelected = recruitment
                }
            }
        }
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
