//
//  HomeViewController.swift
//  SpotifyAPITest
//
//  Created by Ryan Malone on 1/15/20.
//  Copyright © 2020 Ryan Malone. All rights reserved.
//

import UIKit

struct defaultsKeys {
    static let userLoggedIn = "userLoggedIn"
    static let userId = "userId"
}

class HomeViewController: UIViewController {
    @IBOutlet weak var welcomeLabel: UILabel!
    var userHelper = UserHelper()
    var loginViewController: Any!
    var userLoggedInTemp = String()
    var userId = String()
    let defaults = UserDefaults.standard
    let userService = UserService(address: "192.168.1.106:8080")
    
    override func viewWillAppear(_ animated: Bool) {
        if let userLoggedIn = defaults.string(forKey: defaultsKeys.userLoggedIn) {
            userLoggedInTemp = userLoggedIn
            if let id = defaults.string(forKey: defaultsKeys.userId) {
                self.userId = id
            } else {
                self.userId = "ERROR: NOT FOUND"
            }
            self.viewDidLoad()
        } else if (userLoggedInTemp != "true"){
            userLoggedInTemp = "false"
            userId = "" 
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // check to see if the user is logged in based on stored value
        // if the user has never logged in, default to false
        if (userLoggedInTemp == "true") {
            defaults.set("true", forKey: defaultsKeys.userLoggedIn)
            defaults.set(userId, forKey: defaultsKeys.userId)
        }
        else if (userLoggedInTemp == "false") {
            performSegue(withIdentifier: "LoginRequest", sender: self)
            userLoggedInTemp = "true"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "LoginRequest") {
            loginViewController = segue.destination as! LoginViewController
        }
    }
    override func viewDidLoad() {
        if (userLoggedInTemp == "true") {
            if let userInfo = userHelper.userInfo {
                if let displayName = userInfo.displayName {
                    self.welcomeLabel.text = "Welcome \(String(displayName))"
                }
            }
            else {
                // Only make an API call if we don't already have the userInfo
                userService.getInfo(id: userId){
                    (userInfo) in
                    if let userInfo = userInfo {
                        DispatchQueue.main.async {
                            self.userHelper.userInfo = userInfo
                            print("userINFO: ", self.userHelper.userInfo!)
                            if let displayName = self.userHelper.userInfo.displayName {
                                self.welcomeLabel.text = "Welcome \(String(displayName))"
                            }
                        }
                    }
                }
            }
        }
        super.viewDidLoad()
    }
}
