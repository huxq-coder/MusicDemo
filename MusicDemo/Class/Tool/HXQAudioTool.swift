//
//  HXQAudioTool.swift
//  MusicDemo
//
//  Created by huxq-coder on 2020/6/17.
//  Copyright © 2020 huxq. All rights reserved.
//

import UIKit
import AVFoundation

/// 音乐播放工具类
class HXQAudioTool: NSObject {
    
    static var players = [String: AVAudioPlayer]()

    class func playMusicWithFileName(fileName: String) -> AVAudioPlayer {
        var player = players[fileName] ?? nil
        if player == nil {
            let fileUrl = Bundle.main.url(forResource: fileName, withExtension: nil)
            player = try! AVAudioPlayer(contentsOf: fileUrl!)
            players[fileName] = player
            player!.prepareToPlay()
        }
        player!.play()
        return player!
    }
    
    class func pauseMusicWithFileName(fileName: String) {
        let player = players[fileName] ?? nil
        if (player != nil) {
            player?.pause()
        }
    }
    
    class func stopMusicWithFileName(fileName: String) {
        var player = players[fileName] ?? nil
        if (player != nil) {
            player?.stop()
            // 不移除、清空，上一曲、下一曲会从之前的时间进行播放
            players.removeValue(forKey: fileName)
            player = nil
        }
    }
    
}
