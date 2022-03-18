//
//  MyPlayer.swift
//  mpt-noticias
//
//  Created by Luiz Carlos F Ramos on 28/01/22.
//

import Foundation
import UIKit
import AVFoundation

class MyPlayer {
    
    let viewPlayer : UIView
    var url : URL?
    private var player : AVPlayer = AVPlayer()
    
    
    init(viewPlayer: UIView){
        self.viewPlayer = viewPlayer
        self.addPlayerToView(viewPlayer)
    }
    
    fileprivate func addPlayerToView(_ view: UIView) {
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.bounds
        playerLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(playerLayer)
    }
    
    func setPlayer(for urlString: String) -> AVPlayer? {
        guard let url = URL(string: urlString) else {
            
            //TODO: player error and alert
            print("invalid url...")
            return nil
        }
        self.url = url
        let asset = AVAsset(url: url)
        let playerItem = AVPlayerItem(asset: asset)
        player.replaceCurrentItem(with: playerItem)
        return player
    }
    
    func play() {
        
    }
    
}
