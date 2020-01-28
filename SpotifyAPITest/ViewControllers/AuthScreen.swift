////
////  AuthScreen.swift
////  SpotifyAPITest
////
////  Created by Ryan Malone on 12/15/19.
////  Copyright © 2019 Ryan Malone. All rights reserved.
////
//
//import UIKit
//import WebKit
//let ipAddress = "192.168.1.106:8080"
//
//class AuthScreen: UIViewController {
//
//    @IBOutlet weak var webView: WKWebView!
//    @IBOutlet weak var cancelButton: UIButton!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        
//        let url:URL = URL(string: "http://" + ipAddress + "/users/login")!
//        let urlRequest:URLRequest = URLRequest(url: url)
////        webView.load(urlRequest)
//    }
//    
//    func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: ((WKNavigationActionPolicy) -> Void)) {
//        //print("webView:\(webView) decidePolicyForNavigationAction:\(navigationAction) decisionHandler:\(decisionHandler)")
//
//        switch navigationAction.navigationType {
//        case .linkActivated:
//            if navigationAction.targetFrame == nil {
//                self.webView?.load(navigationAction.request)
//            }
//            if let url = navigationAction.request.url, !url.absoluteString.hasPrefix("http://" + ipAddress + "/users/callback") {
//                //UIApplication.shared.openURL(url)
//                print(url.absoluteString)
//                decisionHandler(.cancel)
//            return
//            }
//            default:
//                break
//        }
//
//        if let url = navigationAction.request.url {
//            print(url.absoluteString)
//        }
//        decisionHandler(.allow)
//    }
//
//    func stopLoading() {
//        webView.removeFromSuperview()
//        self.moveToVC()
//    }
//
//    func moveToVC()  {
//        print("Write code where you want to go in app")
//        // Note: [you use push or present here]
////        let vc =
////          self.storyboard?.instantiateViewController(withIdentifier:
////          "storyboardID") as! YourViewControllerName
////        self.navigationController?.pushViewController(vc, animated: true)
//    }
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
