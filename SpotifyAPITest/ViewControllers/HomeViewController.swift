//
//  HomeViewController.swift
//  SpotifyAPITest
//
//  Created by Ryan Malone on 1/15/20.
//  Copyright © 2020 Ryan Malone. All rights reserved.
//

import UIKit
import WebKit
let ipAddress = "192.168.1.106:8080"

class HomeViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    var webView: WKWebView!
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        webView.navigationDelegate = self
        let myURL = URL(string: "http://" + ipAddress + "/users/login")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        self.tabBarController?.tabBar.isHidden = true
        super.viewDidLoad()
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url {
            if url.absoluteString.contains("users/callback") {
                decisionHandler(.cancel)
                print("Attempting to close view")
                self.tabBarController?.tabBar.isHidden = false
                webView.removeFromSuperview()
                return
            }
            else {
                decisionHandler(.allow)
            }
        }
    }
}
