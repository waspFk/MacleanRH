//
//  ListingRecruitmentViewController.swift
//  MacleanRH
//
//  Created by iem on 04/06/2015.
//  Copyright (c) 2015 iem. All rights reserved.
//

import UIKit

class ListingRecruitmentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    var recruitments:[Recruitment]!
    var filteredTableRecuitment:[Recruitment]!
    var searchBarActive :Bool!
    var searchActive : Bool = false
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBarActive = false
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        filteredTableRecuitment = [Recruitment]()
        
        loadData()
    }
    
    
    // MARK: - SearchBar
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        println(" --searchBarTextDidBeginEditing")
        searchBarActive = true
    }
    
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
        
        self.filteredTableRecuitment = self.recruitments.filter(
            {
                ( recruitment: Recruitment) -> Bool in
                println("SearhText = \(searchText)")
                let titleMatch = recruitment.titre.rangeOfString(searchText)
                let workLibelleMatch = recruitment.workLibelle.rangeOfString(searchText)
                
                
                println("Title = \(titleMatch)")
                println("Work = \(workLibelleMatch)")
                
                return (titleMatch != nil) || (workLibelleMatch != nil)
            }
        )
        
        if(filteredTableRecuitment.count == 0){
            searchBarActive = false;
        } else {
            searchBarActive = true;
        }
        
        self.tableView.reloadData()
    }
    
    
    // MARK: - Helper UI
    func loadData() {
        recruitments = RecruitmentManager.SharedManager.getAllRecruitments(nil)
    }
    
    // MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchBarActive  == true){
            return filteredTableRecuitment.count
        }
        return recruitments.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("RecruitmentCell") as! RecruitmentViewCell
        var recruitment:Recruitment!
        
        if(searchBarActive  == true){
            recruitment = filteredTableRecuitment[indexPath.row]
        } else {
            recruitment = recruitments[indexPath.row]
        }
        
        cell.posteLabel.text = recruitment.titre
        cell.descriptionPosteLabel.text = recruitment.workDescription
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "RecruitmentSegue" {
            if let destinationListingCandidat = segue.destinationViewController as? ListingCandidateViewController {
                if let index = tableView.indexPathForSelectedRow()?.row {
                    if(searchBarActive  == true){
                        destinationListingCandidat.recruitment = filteredTableRecuitment[index]
                    } else {
                        destinationListingCandidat.recruitment = recruitments[index]
                    }
                }
            }
        }
    }
    
    }