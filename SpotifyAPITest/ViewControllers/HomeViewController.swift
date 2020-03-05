//
//  HomeViewController.swift
//  SpotifyAPITest
//
//  Created by Ryan Malone on 1/15/20.
//  Copyright © 2020 Ryan Malone. All rights reserved.
//

import UIKit

struct defaultsKeys {
    static let userLoggedIn = "userLoggedIn"
    static let userId = "userId"
    static let address = "address"
    static let useHttps = "useHttps"
    static let useLocalIp = "useLocalIp"
    static let localIp = "localIp"
    static let currentAddress = "currentAddress"
}

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var welcomeLabel: UILabel!
    var userHelper = UserHelper()
    var searchResults: [SongInfo] = []
    var loginViewController: Any!
    var userLoggedInTemp = String()
    var userId = String()
    var albumArt = UIImage()
    let defaults = UserDefaults.standard
    var currentAddress: String?
    var userService: UserService?
    var songService: SongService?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width * 0.90
        let screenHeight = CGFloat(129.0)
        return CGSize(width: screenWidth, height: screenHeight)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Result", for: indexPath) as! SongSearchCell
        let songInfo = self.searchResults[indexPath.row]
        cell.artistLabel.text = songInfo.artist
        cell.songNameLabel.text = songInfo.trackName
        let url = URL(string: songInfo.albumArtUrl!)
        self.getData(from: url!) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url!.lastPathComponent)
            DispatchQueue.main.async() {
                self.albumArt = UIImage(data: data)!
                cell.albumCover.image = UIImage(data: data)
            }
        }
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (address != currentAddress) {
            self.songService = SongService(address: address)
            self.userService = UserService(address: address)
            currentAddress = address
        }
        if let userLoggedIn = defaults.string(forKey: defaultsKeys.userLoggedIn) {
            userLoggedInTemp = userLoggedIn
            if (userLoggedInTemp == "true") {
                if let id = defaults.string(forKey: defaultsKeys.userId) {
                    self.userId = id
                } else {
                    self.userId = "ERROR: NOT FOUND"
                }
            }
            self.viewDidLoad()
        } else if (userLoggedInTemp != "true"){
            userLoggedInTemp = "false"
            userId = "" 
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // check to see if the user is logged in based on stored value
        // if the user has never logged in, default to false
        if (userLoggedInTemp == "false") {
            userLoggedInTemp = "true"
            performSegue(withIdentifier: "LoginRequest", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "LoginRequest") {
            loginViewController = segue.destination as! LoginViewController
        }
        else if (segue.identifier == "PlaySong") {
            let playerView = segue.destination as! PlayerViewController
             if let indexPath = self.collectionView?.indexPath(for: sender as! UICollectionViewCell){
                let songInfo = self.searchResults[indexPath.row]
                let url = URL(string: songInfo.albumArtUrl!)
                self.getData(from: url!) { data, response, error in
                    guard let data = data, error == nil else { return }
                    print(response?.suggestedFilename ?? url!.lastPathComponent)
                    print("Download Finished")
                    DispatchQueue.main.async() {
                        playerView.albumArt.image = UIImage(data: data)!
                    }
                }
                playerView.songURI = songInfo.uri!
                playerView.songId = songInfo.id!
//                if let userInfo = self.userHelper.userInfo {
//                    if let id = userInfo.id {
//                        playerView.id = id
//                    }
//                }
            }
        }
        else if (segue.identifier == "DevSettings") {
            let devSettings = segue.destination as! DeveloperSettingsViewController
            devSettings.defaults = self.defaults
            devSettings.homeViewController = self
        }
    }
    
    override func viewDidLoad() {
        if (userLoggedInTemp == "true") {
            if let userInfo = userHelper.userInfo {
                if let displayName = userInfo.displayName {
                    print("Welcome \(String(displayName))")
                }
            }
            else {
                // Only make an API call if we don't already have the userInfo
                userService!.getInfo(id: userId){
                    (userInfo) in
                    if let userInfo = userInfo {
                        DispatchQueue.main.async {
                            self.userHelper.userInfo = userInfo
                            print("userINFO: ", self.userHelper.userInfo!)
                        }
                    }
                }
            }
//            let profileView = self.tabBarController?.viewControllers![1] as! ProfileViewController
//            profileView.userInfo = userHelper.userInfo
        }
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.searchField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Return Pressed")
        self.searchResults = []
        var searchString: String!
        if let search = textField.text {
            searchString = search
        }
        else {
            searchString = ""
        }
        songService!.search(searchString: searchString, id: userId) {
            (songInfo) in
            DispatchQueue.main.async {
                self.searchResults = songInfo as! [SongInfo]
                self.collectionView.reloadData()
            }
        }
        //dismiss the keyboard (for now)
        self.searchField.endEditing(true)
        return false
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
