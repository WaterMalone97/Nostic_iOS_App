//
//  LoginViewController.swift
//  SpotifyAPITest
//
//  Created by Ryan Malone on 1/28/20.
//  Copyright © 2020 Ryan Malone. All rights reserved.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController, SFSafariViewControllerDelegate {
    var userId = String()
    let url = NSURL(string: "\(address)/users/login")
    var vc: AnyObject?
    @IBOutlet weak var loginButton: UIButton!
    @IBAction func loginButton(_ sender: Any) {
        if let vc = vc {
            present(vc as! SFSafariViewController, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "LoginSuccess") {
            let tabBarController = segue.destination as! UITabBarController
            let homeViewController = tabBarController.viewControllers![0] as! HomeViewController
            homeViewController.defaults.set(userId, forKey: defaultsKeys.userId)
            homeViewController.defaults.set("true", forKey: defaultsKeys.userLoggedIn)
        }
    }
    
    func dismissSafari(userName: String) {
        userId = userName
        safariViewControllerDidFinish(vc as! SFSafariViewController)
        performSegue(withIdentifier: "LoginSuccess", sender: nil)
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vc = SFSafariViewController(url: url! as URL)
        // Do any additional setup after loading the view.
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
