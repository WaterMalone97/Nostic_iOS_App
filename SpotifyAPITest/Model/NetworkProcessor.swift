//
//  NetworkProcessor.swift
//  SpotifyAPITest
//
//  Created by Ryan Malone on 1/28/20.
//  Copyright © 2020 Ryan Malone. All rights reserved.
//

import Foundation

class NetworkProcessor {
    lazy var configuration: URLSessionConfiguration = URLSessionConfiguration.default
    lazy var session: URLSession = URLSession(configuration: self.configuration)
    let url: URL
    init(url: URL) {
        self.url = url
    }
    typealias JSONDictonaryHandler = (([String : Any]?) -> Void)
    
    func downloadJSONFromURL(_ completion: @escaping JSONDictonaryHandler) {
        let request = URLRequest(url: self.url)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                if let httpResponse = response as? HTTPURLResponse {
                    //assume success for now
                    if let data = data {
                        do {
                            let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                            completion(jsonDictionary as? [String : Any])
                        } catch let error as NSError {
                            print("Error processing JSON data: \(error.localizedDescription)")
                        }
                    }
                }
                else {
                    print("Request Error :(")
                }
            }
        }
    dataTask.resume()
    }
}
