//
//  SongService.swift
//  SpotifyAPITest
//
//  Created by Ryan Malone on 2/4/20.
//  Copyright © 2020 Ryan Malone. All rights reserved.
//

import Foundation

class SongService {
    let baseAddress: String
    let userBaseURL: URL?
    
    init(address: String) {
        self.baseAddress = address
        userBaseURL = URL(string: "http://\(address)/songs")
    }
    
    func play(access_token: String, uri: String) -> Bool {
        var playURL = URLComponents(string: "\(userBaseURL!)/play")!
        playURL.queryItems = [
            URLQueryItem(name: "access_token", value: access_token),
            URLQueryItem(name: "uri", value: uri)
        ]
        let networkProcessor = NetworkProcessor(url: playURL.url!)
        networkProcessor.downloadJSONFromURL({ (jsonDictionary) in
            print("playing")
        })
        return true
    }
    
    func search(searchString: String, access_token: String, completion: @escaping(SongInfo?) -> Void) {
        var searchURL = URLComponents(string: "\(userBaseURL!)/search")!
        searchURL.queryItems = [
            URLQueryItem(name: "access_token", value: access_token),
            URLQueryItem(name: "searchString", value: searchString)
        ]
        let networkProcessor = NetworkProcessor(url: searchURL.url!)
        networkProcessor.downloadJSONFromURL({ (jsonDictionary) in
            if let searchResults = jsonDictionary {
                let songInfo = SongInfo(songDictionary: searchResults)
                completion(songInfo)
            } else {
                completion(nil)
            }
        })
    }
}
