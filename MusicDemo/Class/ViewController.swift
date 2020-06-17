//
//  ViewController.swift
//  MusicDemo
//
//  Created by evc_admin on 2020/6/16.
//  Copyright © 2020 d1ev. All rights reserved.
//

import UIKit
import AVFoundation

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
    
    var currentPlayer: AVAudioPlayer?
    
    var timer: Timer?
    
    
    
    // MARK: - play button methods
    // 播放/暂停 方法
    @IBAction func playButtonAction(_ sender: UIButton) {
        if sender.isSelected {
            currentPlayer?.pause()
            removeTimer()
        } else {
            currentPlayer?.play()
            setupTimer()
        }
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func previousButtonAction(_ sender: UIButton) {
        HXQAudioTool.stopMusicWithFileName(fileName: HXQMusicTool.playingMusic().filename)
        HXQMusicTool.setupPlayingMusic(music: HXQMusicTool.previous())
        setupMusic()
    }
    
    @IBAction func nextButtonAction(_ sender: UIButton) {
        HXQAudioTool.stopMusicWithFileName(fileName: HXQMusicTool.playingMusic().filename)
        HXQMusicTool.setupPlayingMusic(music: HXQMusicTool.next())
        setupMusic()
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
        
        self.coverImageView.layer.cornerRadius = self.coverImageView.frame.size.width/2
        self.coverImageView.layer.borderWidth = 5
        self.coverImageView.layer.borderColor = UIColor.gray.cgColor
        
        setupMusic()
    }
    
    func setupMusic() {
        let music = HXQMusicTool.playingMusic()
        musicNameLabel.text = music.name
        singerNameLabel.text = music.singer
        backgroundImageView.image = UIImage(named: music.icon)
        coverImageView.image = UIImage(named: music.icon)
        let player = HXQAudioTool.playMusicWithFileName(fileName: music.filename)
        currentPlayer = player
        playButton.isSelected = player.isPlaying
        totalTimeLabel.text = timeToString(time: player.duration)
        currentTimeLabel.text = timeToString(time: player.currentTime)
        
        removeTimer()
        setupTimer()
    }
    
    /// 设置时间片
    func setupTimer() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
            self.currentTimeLabel.text = self.timeToString(time: self.currentPlayer!.currentTime)
            self.playSlider.value = Float(self.currentPlayer!.currentTime / self.currentPlayer!.duration)
        }
        RunLoop.main.add(self.timer!, forMode: .common)
        self.timer!.fire()
    }
    
    func removeTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }

    func timeToString(time: TimeInterval) -> String {
        let minuate: Int = Int(time / 60)
        let second: Int = Int(round(time).truncatingRemainder(dividingBy: 60))
        return "\(String(format: "%02d", minuate)):\(String(format: "%02d", second))"
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

