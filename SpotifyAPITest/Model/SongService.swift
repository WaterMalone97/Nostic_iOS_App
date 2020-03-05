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
    
    func search(searchString: String, id: String, completion: @escaping([SongInfo?]) -> Void) {
        var searchURL = URLComponents(string: "\(songBaseURL!)/search")!
        searchURL.queryItems = [
            URLQueryItem(name: "id", value: id),
            URLQueryItem(name: "searchString", value: searchString)
        ]
        let networkProcessor = NetworkProcessor(url: searchURL.url!)
        networkProcessor.downloadJSONArrayFromURL({ (songs) in
            var results = [SongInfo]()
            for song in songs {
                let songInfo = SongInfo(songDictionary: song as! [String : Any])
                results.append(songInfo)
            }
            completion(results)
        })
    }
    
    func share(songId: String, id: String) {
        let Url = String(format: "\(songBaseURL!)/share")
        guard let serviceUrl = URL(string: Url) else { return }
        let parameterDictionary = ["songId" : songId, "userId" : id]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        print("BODY", httpBody)
        request.httpBody = httpBody

        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
            }.resume()
    }
}
