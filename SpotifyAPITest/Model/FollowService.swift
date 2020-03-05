//
//  FollowService.swift
//  SpotifyAPITest
//
//  Created by Ryan Malone on 3/1/20.
//  Copyright © 2020 Ryan Malone. All rights reserved.
//

import Foundation

class FollowService {
    
    let baseAddress: String?
    let followBaseURL: URL?
    
    init(address: String) {
        baseAddress = address
        followBaseURL = URL(string: "\(address)/follow")
    }
    
    func getFeed(id: String, completion: @escaping([SongInfo?]) -> Void) {
        var playURL = URLComponents(string: "\(followBaseURL!)/feed")!
        playURL.queryItems = [
            URLQueryItem(name: "id", value: id),
        ]
        let networkProcessor = NetworkProcessor(url: playURL.url!)
        networkProcessor.downloadJSONArrayFromURL({ (songs) in
            var results = [SongInfo]()
            for song in songs {
                let songInfo = SongInfo(songDictionary: song as! [String : Any])
                results.append(songInfo)
            }
            completion(results)
        })
    }
}
