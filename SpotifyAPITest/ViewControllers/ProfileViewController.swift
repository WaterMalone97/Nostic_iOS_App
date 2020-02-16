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
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Result", for: indexPath) as! ProfileCellCollectionViewCell
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
