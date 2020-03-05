//
//  ProfileViewController.swift
//  SpotifyAPITest
//
//  Created by Ryan Malone on 2/15/20.
//  Copyright © 2020 Ryan Malone. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    var songs: [SongInfo] = []
    @IBAction func segmentedButton(_ sender: Any) {
    }
    @IBOutlet weak var collectionView: UICollectionView!
    var userService: UserService?
    var userInfo: UserInfo?
    var currentAddress: String?
    let defaults = UserDefaults.standard
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "PlaySong") {
            let playerView = segue.destination as! PlayerViewController
             if let indexPath = self.collectionView?.indexPath(for: sender as! UICollectionViewCell){
                let songInfo = self.songs[indexPath.row]
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
                //playerView.id = "musicman5385"
                playerView.songId = songInfo.id!
//                if let userInfo = self.userHelper.userInfo {
//                    if let id = userInfo.id {
//                        playerView.id = id
//                    }
//                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        userService = UserService(address: address)
//        if (songs.count == 0) {
        userService!.getLibrary(id: defaults.string(forKey: defaultsKeys.userId)!) {
            (songList) in
            DispatchQueue.main.async {
                self.songs = songList!
                self.collectionView.reloadData()
            }
        }
        //}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width * 0.90
        let screenHeight = CGFloat(82.0)
        return CGSize(width: screenWidth, height: screenHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.songs.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Song", for: indexPath) as! ProfileCellCollectionViewCell
       let songInfo = self.songs[indexPath.row]
       cell.artistLabel.text = songInfo.artist
       cell.songTitleLabel.text = songInfo.trackName
       let url = URL(string: songInfo.albumArtUrl!)
       self.getData(from: url!) { data, response, error in
           guard let data = data, error == nil else { return }
           print(response?.suggestedFilename ?? url!.lastPathComponent)
           DispatchQueue.main.async() {
               cell.albumCover.image = UIImage(data: data)
           }
       }
       return cell
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
