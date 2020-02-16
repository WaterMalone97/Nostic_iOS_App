//
//  UserInfo.swift
//  SpotifyAPITest
//
//  Created by Ryan Malone on 1/28/20.
//  Copyright © 2020 Ryan Malone. All rights reserved.
//

import Foundation

class UserInfo {
    let displayName: String?
    let id: String?
    
    struct UserKeys {
        static let displayName = "display_name"
        static let id = "id"
    }
    
    init (userDictionary: [String: Any]) {
        let displayName = userDictionary[UserKeys.displayName]
        if let displayName = displayName {
            self.displayName = displayName as? String
        } else {
            self.displayName = nil
        }
        
        let id = userDictionary[UserKeys.id]
        if let id = id {
            self.id = id as? String
        } else {
            self.id = nil
        }
    }
}
