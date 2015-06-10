//
//  ListingRecruitmentViewController.swift
//  MacleanRH
//
//  Created by iem on 04/06/2015.
//  Copyright (c) 2015 iem. All rights reserved.
//

import UIKit

class ListingRecruitmentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var recruitments:[Recruitment]!
    var filterTitle = 0
    var filterDate = 0
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    // MARK: - Helper UI
    func loadData() {
        println(" --loadData")
        recruitments = RecruitmentManager.SharedManager.getAllRecruitments(nil)
        
        println(" --loadData : \(recruitments.count)")
    }
    
    
    // MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println(" --numberOfRowsInSection : \(recruitments.count) ")
        return recruitments.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("RecruitmentCell") as! RecruitmentViewCell
        let recruitment = recruitments[indexPath.row]
        
        cell.posteLabel.text = recruitment.titre
        cell.descriptionPosteLabel.text = recruitment.workDescription
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    
    @IBAction func SortListByDate(sender: AnyObject) { // should probably be called sort and not filter
        
        if(self.filterDate == 0){
            self.recruitments.sort({ $0.date.compare($1.date) == NSComparisonResult.OrderedAscending })
            self.filterDate = 1
        }else{
            self.recruitments.sort({ $0.date.compare($1.date) == NSComparisonResult.OrderedDescending })
            self.filterDate = 0
        }
        self.tableView.reloadData(); // notify the table view the data has changed
        
    }
    
    @IBAction func SortListByTitre(sender: AnyObject) {
        if(self.filterTitle == 0){
            self.recruitments.sort(){ $0.titre < $1.titre }
            self.filterTitle = 1
        }else{
            self.recruitments.sort() { $0.titre > $1.titre }
            self.filterTitle = 0
        }
        self.tableView.reloadData(); // notify the table view the data has changed
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "RecruitmentSegue" {
            let destinationListingCandidat = segue.destinationViewController as! ListingCandidateViewController
            
            let indexPath  = self.tableView.indexPathForSelectedRow()!
            let recruitment = recruitments[indexPath.row]
            destinationListingCandidat.recruitment = recruitment
        }
    }
}