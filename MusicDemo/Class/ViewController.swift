//
//  ViewController.swift
//  MusicDemo
//
//  Created by evc_admin on 2020/6/16.
//  Copyright © 2020 d1ev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // 背景图片
    @IBOutlet weak var backgroundImageView: UIImageView!
    // 歌曲名称
    @IBOutlet weak var musicNameLabel: UILabel!
    // 歌手名称
    @IBOutlet weak var singerNameLabel: UILabel!
    // 封面图片
    @IBOutlet weak var coverImageView: UIImageView!
    // 当前时间
    @IBOutlet weak var currentTimeLabel: UILabel!
    // 全部时长
    @IBOutlet weak var totalTimeLabel: UILabel!
    // 进度条
    @IBOutlet weak var playSlider: UISlider!
    // 播放/暂停
    @IBOutlet weak var playButton: UIButton!
    // 上一首
    @IBOutlet weak var previousButton: UIButton!
    // 下一首
    @IBOutlet weak var nextButton: UIButton!
    
    // MARK: - play button methods
    // 播放/暂停 方法
    @IBAction func playButtonAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func previousButtonAction(_ sender: UIButton) {
        
    }
    
    @IBAction func nextButtonAction(_ sender: UIButton) {
        
    }
    
    // MARK: - slider methods
    @IBAction func sliderBegin(_ sender: UISlider) {
        
    }
    
    @IBAction func sliderEnd(_ sender: UISlider) {
        
    }
    
    @IBAction func sliderValueChange(_ sender: UISlider) {
        
    }
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playSlider.setThumbImage(UIImage(named: "player_slider_playback_thumb"), for: .normal)
        
        setupMusic()
    }
    
    func setupMusic() {
        let music = HXQMusicTool.playingMusic()
        musicNameLabel.text = music.name
        singerNameLabel.text = music.singer
        backgroundImageView.image = UIImage(named: music.icon)
        coverImageView.image = UIImage(named: music.icon)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

