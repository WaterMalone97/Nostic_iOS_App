//
//  HomeViewController.swift
//  SpotifyAPITest
//
//  Created by Ryan Malone on 1/15/20.
//  Copyright © 2020 Ryan Malone. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var welcomeLabel: UILabel!
    var loginViewController: Any!
    var userLoggedIn = String()
    var userId = String()
    override func viewDidAppear(_ animated: Bool) {
        if (userLoggedIn == "false" || userLoggedIn == "") {
            performSegue(withIdentifier: "LoginRequest", sender: self)
            userLoggedIn = "true"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "LoginRequest") {
            loginViewController = segue.destination as! LoginViewController
        }
    }
    override func viewDidLoad() {
        welcomeLabel.text = "Welcome \(userId)"
        super.viewDidLoad()
    }
}
