//
//  FeedViewController.swift
//  SpotifyAPITest
//
//  Created by Ryan Malone on 3/1/20.
//  Copyright © 2020 Ryan Malone. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var followService: FollowService?
    var albumArt: UIImage?
    var songFeed = [SongInfo]()
    let defaults = UserDefaults.standard
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width * 0.90
        let screenHeight = CGFloat(203)
        return CGSize(width: screenWidth, height: screenHeight)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.songFeed.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Song", for: indexPath) as! SongFeedCell
        let songInfo = self.songFeed[indexPath.row]
        cell.artistLabel.text = songInfo.artist
        cell.songTitleLabel.text = songInfo.trackName
        let url = URL(string: songInfo.albumArtUrl!)
        self.getData(from: url!) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url!.lastPathComponent)
            DispatchQueue.main.async() {
                self.albumArt = UIImage(data: data)!
                cell.albumArt.image = UIImage(data: data)
            }
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "PlaySong") {
            let playerView = segue.destination as! PlayerViewController
             if let indexPath = self.collectionView?.indexPath(for: sender as! UICollectionViewCell){
                let songInfo = self.songFeed[indexPath.row]
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
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        followService = FollowService(address: address)
        followService?.getFeed(id: defaults.string(forKey: defaultsKeys.userId)!) {
            (songInfo) in
            DispatchQueue.main.async {
                self.songFeed = songInfo as! [SongInfo]
                self.collectionView.reloadData();
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
