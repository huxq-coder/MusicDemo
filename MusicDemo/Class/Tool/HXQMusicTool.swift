//
//  HXQMusicTool.swift
//  MusicDemo
//
//  Created by huxq-coder on 2020/6/16.
//  Copyright © 2020 huxq. All rights reserved.
//

import UIKit

/// 音乐工具类
class HXQMusicTool: NSObject {

    static var _musics: [HXQMusicModel] = []
    static var _playingMusic: HXQMusicModel?
    
    /// 获取所有音乐
    class func musics() -> [HXQMusicModel] {
        if _musics.count == 0 {
            let array: NSArray = NSArray(contentsOfFile: Bundle.main.path(forResource: "Musics", ofType: "plist")!)!
            for dict in array {
                let model = HXQMusicModel(fromDictionary: dict as! [String : Any])
                _musics.append(model)
            }
        }
        return _musics
    }
    
    class func playingMusic() -> HXQMusicModel {
        if _playingMusic == nil {
            _playingMusic = musics()[1]
        }
        return _playingMusic!
    }
    
}
