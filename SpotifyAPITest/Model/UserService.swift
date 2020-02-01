//
//  UserService.swift
//  SpotifyAPITest
//
//  Created by Ryan Malone on 1/28/20.
//  Copyright © 2020 Ryan Malone. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class UserService {
    let baseAddress: String
    let userBaseURL: URL?
    
    init(address: String) {
        self.baseAddress = address
        userBaseURL = URL(string: "http://\(address)/users")
    }
    
    func login (completion: @escaping(UserInfo?) -> Void) {
        if let loginURL = URL(string: "\(userBaseURL!)/login") {
            print(loginURL)
            let networkProcessor = NetworkProcessor(url: loginURL)
            networkProcessor.downloadJSONFromURL({ (jsonDictionary) in
                print(jsonDictionary!)
                if let currentUserDictionary = jsonDictionary?["body"] as?[String : Any] {
                    let userInfo = UserInfo(userDictionary: currentUserDictionary)
                    completion(userInfo)
                } else {
                    completion(nil)
                }
            })
        }
    }
}
