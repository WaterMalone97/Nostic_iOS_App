//
//  UserInfo.swift
//  SpotifyAPITest
//
//  Created by Ryan Malone on 1/28/20.
//  Copyright © 2020 Ryan Malone. All rights reserved.
//

import Foundation

class UserInfo {
    let accessToken: String?
    let refreshToken: String?
    let displayName: String?
    let id: String?
    
    struct UserKeys {
        static let accessToken = "access_token"
        static let refreshToken = "refresh_token"
        static let displayName = "display_name"
        static let id = "id"
    }
    
    init (userDictionary: [String: Any]) {
        let accessToken = userDictionary[UserKeys.accessToken]
        if let accessToken = accessToken {
            self.accessToken = accessToken as? String
        } else {
            self.accessToken = nil
        }
        
        let refreshToken = userDictionary[UserKeys.accessToken]
        if let refreshToken = refreshToken {
            self.refreshToken = refreshToken as? String
        } else {
            self.refreshToken = nil
        }
        
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
