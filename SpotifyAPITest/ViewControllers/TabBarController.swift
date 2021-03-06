//
//  TabBarController.swift
//  SpotifyAPITest
//
//  Created by Ryan Malone on 1/30/20.
//  Copyright © 2020 Ryan Malone. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    var homeViewController: HomeViewController!
    var userId = ""
    var userLoggedIn = "false"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        homeViewController = self.children[0] as? HomeViewController
        homeViewController.userId = self.userId
        homeViewController.userLoggedIn = self.userLoggedIn
        homeViewController.viewDidLoad()
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
