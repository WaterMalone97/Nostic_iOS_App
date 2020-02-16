//
//  PlayerViewController.swift
//  SpotifyAPITest
//
//  Created by Ryan Malone on 2/5/20.
//  Copyright © 2020 Ryan Malone. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController {
    
    var songURI = String()
    let songService = SongService(address: address)
    var id = String()
    
    @IBAction func playPauseButton(_ sender: Any) {
    }
    
    @IBOutlet weak var albumArt: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        songService.play(id: self.id, uri: self.songURI)
        // Do any additional setup after loading the view.
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
