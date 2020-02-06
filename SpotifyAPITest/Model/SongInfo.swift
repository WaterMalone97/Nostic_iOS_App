//
//  SongInfo.swift
//  SpotifyAPITest
//
//  Created by Ryan Malone on 2/4/20.
//  Copyright © 2020 Ryan Malone. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

class SongInfo {
    let uri: String?
    let artist: String?
    let trackName: String?
    var albumArtUrl: String?
    let album: String?
    
    struct SongKeys {
        static let uri = "uri"
        static let artists = "artists"
        static let name = "name"
        static let images = "images"
        static let album = "album"
    }
    
    init (songDictionary: [String: Any]) {
        let uri = songDictionary[SongKeys.uri]
        if let uri = uri {
            self.uri = uri as? String
        } else {
            self.uri = nil
        }
        
        let artists = songDictionary[SongKeys.artists] as! NSArray
        let artistsDic = (artists[0] as! NSDictionary)
        self.artist = artistsDic["name"] as? String
        
        let trackName = songDictionary[SongKeys.name]
        if let trackName = trackName {
            self.trackName = trackName as? String
        } else {
            self.trackName = nil
        }
        
        let album = songDictionary[SongKeys.album] as! NSDictionary
        self.album = album["name"] as? String
        let images = album[SongKeys.images] as! NSArray
        let image = images[0] as? NSDictionary
        self.albumArtUrl = (image?["url"] as? String)!
    }
    
}
