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
    
    func UIColorFromRGB(colorCode: String, alpha: Float = 1.0) -> UIColor {
        var scanner = NSScanner(string:colorCode)
        var color:UInt32 = 0;
        scanner.scanHexInt(&color)
        
        let mask = 0x000000FF
        let r = CGFloat(Float(Int(color >> 16) & mask)/255.0)
        let g = CGFloat(Float(Int(color >> 8) & mask)/255.0)
        let b = CGFloat(Float(Int(color) & mask)/255.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: CGFloat(alpha))
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
        
        cell.backgroundColor = UIColorFromRGB(candidate.state_candidature.color, alpha: 0.5)
        
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
                }
            }
        }
    }
}
