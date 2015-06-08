//
//  ListingCandidateViewController.swift
//  MacleanRH
//
//  Created by iem on 04/06/2015.
//  Copyright (c) 2015 iem. All rights reserved.
//

import UIKit

class ListingCandidateViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var candidates:[Candidate]!
    var recruitment:Recruitment!

    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    // MARK: - Helper UI
    func loadData() {
        candidates = recruitment.getCandidatesArray()
        println("Count candidates = \(candidates.count)")
    }
    
    
    // MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println(" --numberOfRowsInSection : \(candidates.count) ")
        return candidates.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("CandidateCell") as! CandidateViewCell
        let candidate = candidates[indexPath.row]
        
        cell.firstName.text  = candidate.firstName
        cell.lastName.text   = candidate.lastName
        
        if let picture = candidate.photo {
            cell.avatar.image = UIImage(data: picture)
        }
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "CandidateViewSegue" {
            if let destination = segue.destinationViewController as? CandidateViewController {
                if let index = tableView.indexPathForSelectedRow()?.row {
                    destination.candidate = candidates[index]
                    destination.recruitment = recruitment
                }
            }
        }
    }
}
