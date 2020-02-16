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
        userBaseURL = URL(string: "\(address)/users")
    }
    
    func getLibrary(id: String, completion: @escaping([SongInfo]?) -> Void) {
        var libraryUrl = URLComponents(string: "\(userBaseURL!)/library")!
        libraryUrl.queryItems = [
            URLQueryItem(name: "id", value: id)
        ]
        let networkProcessor = NetworkProcessor(url: libraryUrl.url!)
        networkProcessor.downloadJSONFromURL({ (jsonDictionary) in
            if let library = jsonDictionary {
                var songInfoArray = [SongInfo]()
                let songs = library["Songs"] as! NSArray
                for song in songs {
                    songInfoArray.append(SongInfo(songDictionary: song as! [String : Any]))
                }
                completion(songInfoArray)
            } else {
                completion(nil)
            }
        })
    }
    
    func getInfo (id: String, completion: @escaping(UserInfo?) -> Void) {
        var infoURL = URLComponents(string: "\(userBaseURL!)/info")!
        infoURL.queryItems = [
            URLQueryItem(name: "id", value: id)
        ]
        let networkProcessor = NetworkProcessor(url: infoURL.url!)
        networkProcessor.downloadJSONFromURL({ (jsonDictionary) in
            print(jsonDictionary!)
            if let currentUserDictionary = jsonDictionary {
                let userInfo = UserInfo(userDictionary: currentUserDictionary)
                completion(userInfo)
            } else {
                completion(nil)
            }
        })
    }
}
