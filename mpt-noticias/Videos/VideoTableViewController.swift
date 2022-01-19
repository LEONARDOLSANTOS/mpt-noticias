//
//  VideoTableViewController.swift
//  mpt-noticias
//
//  Created by Luiz Carlos F Ramos on 05/01/22.
//

import UIKit
import AVFoundation
import AVKit

class VideoTableViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var player: VideoPlayer!
    @IBOutlet weak var lbVideoTitle: UILabel!
    @IBOutlet weak var lbVideoTime: UILabel!
    @IBOutlet weak var tvVideoTable: UITableView!
    
    // MARK: - Constants and Variables
    
    let reusedCellIdentifier = "videoCell"
 //   var player: AVPlayer?
   
//    let playerItems = [
//        PlayerItem(title: "Driving a Cycle experience.", url: "https://content.jwplatform.com/manifests/yp34SRmf.m3u8", thumbnail: "2"),
//        PlayerItem(title: "The Durian Open Movie Project.", url: "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8", thumbnail: "3"),
//        PlayerItem(title: "Table Ronde.", url: "https://mnmedias.api.telequebec.tv/m3u8/29880.m3u8", thumbnail: "4"),
//        PlayerItem(title: "What is this event? ... parker.", url: "https://bitdash-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8", thumbnail: "5")
//    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //iniciatePlayer()
        //initial()
        
        tvVideoTable.restorationIdentifier = reusedCellIdentifier
        tvVideoTable.delegate = self
        tvVideoTable.dataSource = self
        tvVideoTable.tableHeaderView = UIView()
//        vid()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        player?.pause()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        player?.play()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        player?.pause()
    }
    
    
    internal func vid(){
        let  urlString = "https://content.jwplatform.com/manifests/yp34SRmf.m3u8"
        player.playVideoWith(URL: urlString)
        
    }
    
    /*
    internal func initial(){
        videoPlayer  = MBVideoPlayerView(configuration: configuration , theme: nil, header: nil)
        vwVideoPlayer.addSubview(videoPlayer)
        videoPlayer.translatesAutoresizingMaskIntoConstraints = false
        
//        videoPlayer.leadingAnchor.constraint(equalTo: vwVideoPlayer.leadingAnchor).isActive = true
//        videoPlayer.trailingAnchor.constraint(equalTo: vwVideoPlayer.trailingAnchor).isActive = true
//        videoPlayer.topAnchor.constraint(equalTo: vwVideoPlayer.topAnchor).isActive = true
//        videoPlayer.heightAnchor.constraint(equalToConstant: vwVideoPlayer.frame.size.width - 50).isActive = true
        
        videoPlayer.pinEdges(to: vwVideoPlayer)
        
        
        videoPlayer.configuration = configuration
        if let currentItem = playerItems.first {
            videoPlayer.setPlayList(currentItem: currentItem, items: playerItems, fullScreenView: view)
        }
        videoPlayer.playerStateDidChange = { (state) in
//            print(state.rawValue )
            switch state {
            case .playedToTheEnd:
                print("playedToTheEnd - \(state.self)")
                self.videoPlayer.playPause(false)
                
            default:
                print("default")
            }
            print("playedToTheEnd - \(state.self)")
        }
    
//        videoPlayer.playPause(<#T##isActive: Bool##Bool#>)
//        
//        isActive = !isActive
//        playButton.setImage(Controls.playpause(isActive).image, for: .normal)
    }
    
    */
    
    /*
    internal func iniciatePlayer(){
        let url1 = URL(string: "https://wolverine.raywenderlich.com/content/ios/tutorials/video_streaming/foxVillage.mp4")!
        let asset = AVAsset(url: url1)
        let playerItem = AVPlayerItem(asset: asset)
        let player = AVPlayer(playerItem: playerItem)
        self.player = player
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.vwVideoPlayer.bounds //bounds of the view in which AVPlayer should be displayed
        playerLayer.videoGravity = .resizeAspectFill
        vwVideoPlayer.layer.addSublayer(playerLayer)
        

        player.play()
        
//        if player == nil {
//            if let videoPlayer = GPVideoPlayer.initialize(with: vwVideoPlayer.bounds) {
//                player = videoPlayer
//                vwVideoPlayer.addSubview(player!)
//
//                let url1 = URL(string: "https://youtu.be/cO0gP7wLSh8")!
//                player?.loadVideo(with: url1)
//                player?.playVideo()
//            }
//
//
//
//        }
    }
    
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension VideoTableViewController: UITableViewDelegate {
    
}

extension VideoTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
    
}
