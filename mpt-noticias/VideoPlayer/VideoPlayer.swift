//
//  VideoPlayer.swift
//  mpt-noticias
//
//  Created by Luiz Carlos F Ramos on 18/01/22.
//

import Foundation
import AVKit

class VideoPlayer: UIView {
    @IBOutlet weak var vwPlayer: UIView!
    var player: AVPlayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        let storyboard = UIStoryboard(name: "Videos", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "videoTableView")
        let views = vc.view.subviews
    
        let viewFromXib = views.first { view in
            return view.restorationIdentifier == "videoPlayer"
        }
       
       
        
//        let viewFromXib = Bundle.main.loadNibNamed("Videos", owner: self, options: nil)![0] as! UIView
        viewFromXib?.frame = self.bounds
        addSubview(viewFromXib!)
        addPlayerToView(self.vwPlayer)
    }
    
    fileprivate func addPlayerToView(_ view: UIView) {
        player = AVPlayer()
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.bounds
        playerLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(playerLayer)
        NotificationCenter.default.addObserver(self, selector: #selector(playerEndPlay), name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    func playVideoWithLocalFileName(_ fileName: String, ofType type:String) {
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: type) else { return }
        let videoURL = URL(fileURLWithPath: filePath)
        let playerItem = AVPlayerItem(url: videoURL)
        player?.replaceCurrentItem(with: playerItem)
        player?.play()
    }
    
    @objc func playerEndPlay() {
        print("Player ends playing video")
    }
    
    
    func playVideoWith(URL url: String){
        guard let url1 = URL(string: url) else {
            print("Error: invalid url address - \(#file) - \(#function) - \(#line - 2)")
            return }
        let asset = AVAsset(url: url1)
        let playerItem = AVPlayerItem(asset: asset)
        player?.replaceCurrentItem(with: playerItem)
        player?.play()
       
    }
    
    
    
    
}
