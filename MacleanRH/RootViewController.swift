//
//  RootViewController.swift
//  MacleanRH
//
//  Created by iem on 11/06/2015.
//  Copyright (c) 2015 iem. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    static let SIMPLE_VIEW = 1
    static let FULL_VIEW = 2
    
    let storyBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
    
    internal var typeView:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let view = typeView {
            if view == RootViewController.FULL_VIEW {
                self.navigationController?.setNavigationBarHidden(true, animated: animated)
            }
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
    @IBAction func launchRecrutment(sender: UIButton) {
        println("LaunchRecruitment")
        
        let viewController = storyBoard.instantiateViewControllerWithIdentifier("RecruitmentListViewID") as! ListingRecruitmentViewController
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    @IBAction func launchEmployee(sender: UIButton) {
        println("launchEmployee")
        
        let viewController = storyBoard.instantiateViewControllerWithIdentifier("EmployeeListViewID") as! ListingEmployeeViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func launchCalendar(sender: UIButton) {
        println("launchCalendar")
        UIApplication.sharedApplication().openURL(NSURL(string: "calshow://")!)
    }
}
