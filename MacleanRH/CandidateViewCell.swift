//
//  CandidateViewCell.swift
//  MacleanRH
//
//  Created by iem on 04/06/2015.
//  Copyright (c) 2015 iem. All rights reserved.
//

import UIKit

class CandidateViewCell: UITableViewCell {

    @IBOutlet var avatar: UIImageView!
    @IBOutlet var lastName: UILabel!
    @IBOutlet var firstName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.avatar.image = UIImage(named: "noimage.png")
        self.avatar.frame = CGRectMake(0, 0, 100, 100)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
