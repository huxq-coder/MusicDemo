//
//  ViewController.swift
//  MusicDemo
//
//  Created by evc_admin on 2020/6/16.
//  Copyright © 2020 d1ev. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, CAAnimationDelegate, UIScrollViewDelegate {
    
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
    // 歌词view
    @IBOutlet weak var licView: HXQLicView!
    // 歌词label
    @IBOutlet weak var licLabel: UILabel!
    
    var currentPlayer: AVAudioPlayer?
    
    var timer: Timer?
    var licTimer: Timer?
    
    
    
    // MARK: - play button methods
    // 播放/暂停 方法
    @IBAction func playButtonAction(_ sender: UIButton) {
        if sender.isSelected {
            currentPlayer?.pause()
            removeTimer()
            pauseAnimation()
        } else {
            currentPlayer?.play()
            setupTimer()
            continueAnimation()
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
        removeTimer()
    }
    
    @IBAction func sliderEnd(_ sender: UISlider) {
        currentPlayer?.currentTime = Double(sender.value) * currentPlayer!.duration
        setupTimer()
    }
    
    @IBAction func sliderTapAction(_ sender: UITapGestureRecognizer) {
        let point = sender.location(in: sender.view)
        let ratio = point.x / sender.view!.frame.size.width
        
        currentPlayer?.currentTime = Double(ratio) * currentPlayer!.duration
        currentTimeLabel.text = timeToString(time: Double(ratio) * currentPlayer!.duration)
        playSlider.value = Float(ratio)
    }
    
    @IBAction func sliderValueChange(_ sender: UISlider) {
        currentTimeLabel.text = timeToString(time: Double(sender.value) * currentPlayer!.duration)
    }
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playSlider.setThumbImage(UIImage(named: "player_slider_playback_thumb"), for: .normal)
        
        self.coverImageView.layer.cornerRadius = self.coverImageView.frame.size.width/2
        self.coverImageView.layer.borderWidth = 5
        self.coverImageView.layer.borderColor = UIColor.gray.cgColor
        
        self.licView.contentSize = CGSize(width: self.view.frame.size.width*2, height: 0)
        
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
        
        self.licView.licName = music.lrcname
        
        removeTimer()
        setupTimer()
        removeLicTimer()
        setupLicTimer()
        
        startAnimation()
    }
    
    // 开启封面图旋转动画
    func startAnimation() {
        let animate = CABasicAnimation(keyPath: "transform.rotation.z")
        animate.delegate = self
        animate.fromValue = 0
        animate.toValue = Double.pi * 2
        animate.duration = 30
        animate.repeatCount = Float(NSIntegerMax)
        self.coverImageView.layer.add(animate, forKey: "coverImageTransformZ")
    }
    
    func pauseAnimation() {
        let time = self.coverImageView.layer.convertTime(CACurrentMediaTime(), from: nil)
        self.coverImageView.layer.speed = 0
        self.coverImageView.layer.timeOffset = time
    }
    
    func continueAnimation() {
        let pausedTime = self.coverImageView.layer.timeOffset
        self.coverImageView.layer.speed = 1.0
        self.coverImageView.layer.timeOffset = 0
        self.coverImageView.layer.beginTime = 0
        let continueTime = self.coverImageView.layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        self.coverImageView.layer.beginTime = continueTime
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if (anim.value(forKey: "coverImageTransformZ") != nil) {
            print(flag)
        }
    }
    
    // MARK: - 时间片 methods
    /// 设置播放时间的时间片
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
    
    /// 设置歌词滚动的时间片
    func setupLicTimer() {
        self.licTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
            self.licView.currentTime = self.currentPlayer?.currentTime
            print("---------")
        }
        RunLoop.main.add(self.licTimer!, forMode: .common)
        self.licTimer!.fire()
    }
    
    func removeLicTimer() {
        self.licTimer?.invalidate()
        self.licTimer = nil
    }

    func timeToString(time: TimeInterval) -> String {
        let minuate: Int = Int(time / 60)
        let second: Int = Int(round(time).truncatingRemainder(dividingBy: 60))
        return "\(String(format: "%02d", minuate)):\(String(format: "%02d", second))"
    }
    
    // MARK: - scrollview delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 歌词view滑动模糊
        let point = scrollView.contentOffset
        let alpha = 1 - point.x / scrollView.frame.size.width
        self.coverImageView.alpha = alpha
        self.licLabel.alpha = alpha
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

