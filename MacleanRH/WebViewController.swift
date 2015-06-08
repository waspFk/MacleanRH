//
//  WebViewController.swift
//  MacleanRH
//
//  Created by iem on 08/06/2015.
//  Copyright (c) 2015 iem. All rights reserved.
//

import Foundation
import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let request = NSURLRequest(URL: NSURL(string: url!)!)
        webView.loadRequest(request)
    }
    
    @IBAction func stop(sender: AnyObject) {
        webView.stopLoading()
    }
    
    
    @IBAction func doRefresh(sender: AnyObject) {
        webView.reload()
    }
    
    @IBAction func goBack(sender: AnyObject) {
        webView.goBack()
    }
    
    @IBAction func goForward(sender: AnyObject) {
        webView.goForward()
    }
}