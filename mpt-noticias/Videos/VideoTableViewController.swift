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
    
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var lbVideoTitle: UILabel!
    @IBOutlet weak var lbVideoTime: UILabel!
    @IBOutlet weak var tvVideoTable: UITableView!
    
    
    
    //MARK: - Player Outlets
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var btVolume: UIButton!
    @IBOutlet weak var btBackforward: UIButton!
    @IBOutlet weak var btPlay: UIButton!
    @IBOutlet weak var btFastforward: UIButton!
    @IBOutlet weak var btFullScreen: UIButton!
    

    
        // MARK: - Constants and Variables
    
    let reusedCellIdentifier = "videoCell"
    var originalVideoPlayerBounds : CGRect?
    var videoPlayer: AVPlayer = AVPlayer()
    var isPlaying: Bool = false
   
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
        
        fetchVideos { data in
            dump(data)
            
        }
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
    
//MARK: - Observer Method
    
    override class func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "timeControlStatus",
            let change = change,
            let newValue = change[.newKey] as? Int,
           let oldValue = change[.oldKey] as? Int {
            
            let oldStatus = AVPlayer.TimeControlStatus(rawValue: oldValue)
            let newStatus = AVPlayer.TimeControlStatus(rawValue: newValue)
            
            if newStatus != oldStatus {
                DispatchQueue.main.async {
                    if newStatus == .playing || newStatus == .paused {
                        //TODO:
                       // self?.loaderView.isHidden = true
                    } else {
                        //TODO: 
                        // self.loaderView.isHidden = false
                    }
                    
                }
            }
        }
    }
    //MARK: - Video Player Functions
    internal func setupPlayer(){
        let playerLayer = AVPlayerLayer(player: videoPlayer)
        playerLayer.frame = playerView.bounds
        playerLayer.videoGravity = .resizeAspectFill
        playerView.layer.addSublayer(playerLayer)
        setupVideoPlayerProgressBar()
        createVideoObserver()
        
    }
    
    internal func playVideo(){
        
//        guard let play = (videoPlayer.currentItem?.asset as? AVURLAsset)?.url else {
//            return
//        }
        videoPlayer.play()
        isPlaying = true
    }
    
    internal func playVideo(withURL url: URL){
        
        let asset = AVAsset(url: url)
        let playerItem = AVPlayerItem(asset: asset)
        videoPlayer.replaceCurrentItem(with: playerItem)
        videoPlayer.play()
        isPlaying = true
    }
    
    internal func playVideosInAQueue(withURLs urls: [URL]){
        var playerItems = [AVPlayerItem]()
        
        urls.forEach { url  in
            let asset = AVAsset(url: url)
            let playerItem = AVPlayerItem(asset: asset)
            playerItems.append(playerItem)
        }
        
        
    }
    
    internal func pauseVideo() {
        if isPlaying {
            videoPlayer.pause()
        }
        isPlaying = false
    }
    
    
    internal func switchVideoVolume(){
        videoPlayer.isMuted = !videoPlayer.isMuted
    }
    
    
    func rewindVideo(by seconds: Float64){
        
        let currentTime = videoPlayer.currentTime()
        var newTime = CMTimeGetSeconds(currentTime) - seconds
        if newTime <= 0 {
            newTime = 0
        }
        videoPlayer.seek(to: CMTime(value: CMTimeValue(newTime * 1000), timescale: 1000)) { isCompleted in
            //TODO: Do something after changing the playback time
        }
    }
    
    func forwadVideo(by seconds: Float64){
        let currentTime = videoPlayer.currentTime()
        guard let duration = videoPlayer.currentItem?.duration else {
            print("Error getting the duration of current Item of Video Player")
            return
        }
        
        var newTime = CMTimeGetSeconds(currentTime) + seconds
        if newTime >= CMTimeGetSeconds(duration){
            newTime = CMTimeGetSeconds(duration)
        }
        
        videoPlayer.seek(to: CMTime(value: CMTimeValue(newTime * 1000), timescale: 1000)) { [weak self] isCompleted  in
            //TODO: Do something after changing the playback time
        }
    }
    
    internal func setupVideoPlayerProgressBar(){
        
                
        videoPlayer.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 2), queue: .main) { [weak self] progressTime  in
            
            guard (self?.videoPlayer.currentItem?.duration) != nil else {
                print("Error getting the duration of current Item of Video Player")
                return
            }
            
            let duration = self?.videoPlayer.currentItem?.duration
            let durationSeconds = CMTimeGetSeconds(duration!)
            let seconds = CMTimeGetSeconds(progressTime)
            let progress = Float(seconds/durationSeconds)
            self?.progressBar.progress = progress
            if progress >= 1.0 {
                self?.progressBar.progress = 0.0
            }
        }
    }
    
    internal func createVideoObserver(){
        videoPlayer.addObserver(self, forKeyPath: "timeControlStatus", options: [.old, .new], context: nil)
    }
    
    
    
    
//    
//    internal func vid(){
//        let  urlString = "https://content.jwplatform.com/manifests/yp34SRmf.m3u8"
//        player.playVideoWith(URL: urlString)
//        
//    }
    
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


//Testing api
extension VideoTableViewController {
    
    func fetchVideos(handler: @escaping((Any?) -> Void)  ){
        
        guard let url = URL(string: "https://mpt.mp.br/pgt/videos/@search?fullobjects&portal_type=video") else {
            print("Cannot convert string to URL")
            return handler(nil)
        }
 
        
        
        ///Chamada API
        let configuration : URLSessionConfiguration = {
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = [
                "Content-Type": "application/json", "Accept": "application/json"]
           return configuration
        }()
        
        let session = URLSession(configuration: configuration)
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                print("Found error: \(error?.localizedDescription)")
            } else {
                if let data = data,  let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    
                    let welcome = try! JSONDecoder().decode(Welcome.self, from: data)
                    
                    return handler(welcome)
                }
            }
            
        }
        
        task.resume()
    }
}
