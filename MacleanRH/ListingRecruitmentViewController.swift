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