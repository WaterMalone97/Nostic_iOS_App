//
//  AppDelegate.swift
//  SpotifyAPITest
//
//  Created by Ryan Malone on 11/19/19.
//  Copyright © 2019 Ryan Malone. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print(url)
        return true
    }
}

