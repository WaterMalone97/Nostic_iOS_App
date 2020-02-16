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
    let songBaseURL: URL?
    
    init(address: String) {
        self.baseAddress = address
        songBaseURL = URL(string: "\(address)/songs")
    }
    
    func play(id: String, uri: String) -> Bool {
        var playURL = URLComponents(string: "\(songBaseURL!)/play")!
        playURL.queryItems = [
            URLQueryItem(name: "id", value: id),
            URLQueryItem(name: "uri", value: uri)
        ]
        let networkProcessor = NetworkProcessor(url: playURL.url!)
        networkProcessor.downloadJSONFromURL({ (jsonDictionary) in
            print("playing")
        })
        return true
    }
    
    func search(searchString: String, id: String, completion: @escaping(SongInfo?) -> Void) {
        var searchURL = URLComponents(string: "\(songBaseURL!)/search")!
        searchURL.queryItems = [
            URLQueryItem(name: "id", value: id),
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
