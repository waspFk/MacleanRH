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

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    // MARK: - Helper UI
    func loadData() {
        println(" --loadData")
        candidates = CandidateManager.SharedManager.getAllCandidates(nil)
    }
    
    
    // MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println(" --numberOfRowsInSection : \(candidates.count) ")
        return candidates.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("candidateCell") as! CandidateViewCell
        let candidate = candidates[indexPath.row]
        
        cell.firstName.text  = candidate.firstName
        cell.lastName.text   = candidate.lastName
        //cell.avatar.image = UIImage(data: candidate.photo)
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
