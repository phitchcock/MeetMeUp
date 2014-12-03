//
//  WebViewController.swift
//  MeetMeUp
//
//  Created by Peter Hitchcock on 12/3/14.
//  Copyright (c) 2014 Peter Hitchcock. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {

    var event: Event!

    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        homeView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func loadURL(url: String) {
        let url = NSURL(string: url)
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
    }

    func homeView() {
        loadURL(event.eventURL)
    }
    @IBAction func forwardButton(sender: AnyObject) {
        webView.goForward()
    }

    @IBAction func backButton(sender: AnyObject) {
        webView.goBack()
    }

    func webViewDidStartLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }

    func webViewDidFinishLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
}
