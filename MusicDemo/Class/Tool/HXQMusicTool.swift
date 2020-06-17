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

    static private var _musics: [HXQMusicModel] = []
    static private var _playingMusic: HXQMusicModel?
    
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
    
    class func setupPlayingMusic(music: HXQMusicModel) {
        _playingMusic = music
    }
    
    class func previous() -> HXQMusicModel {
        let index = musics().firstIndex { (model) -> Bool in
            return _playingMusic?.name == model.name
        }
        var previousIndex = index! - 1
        if previousIndex < 0 {
            previousIndex = musics().count - 1
        }
        let previous = musics()[previousIndex]
        return previous
    }
    
    class func next() -> HXQMusicModel {
        let index = musics().firstIndex { (model) -> Bool in
            return _playingMusic?.name == model.name
        }
        var nextIndex = index! + 1
        if nextIndex >= musics().count {
            nextIndex = 0
        }
        let next = musics()[nextIndex]
        return next
    }
    
}
