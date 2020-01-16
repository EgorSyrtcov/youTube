//
//  VideoLauncer.swift
//  Temp
//
//  Created by Egor Syrtcov on 1/15/20.
//  Copyright © 2020 Egor Syrtcov. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    
    var player: AVPlayer?
    var isPlaying = true
    
    
    let controlsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView()
        let transfrom = CGAffineTransform.init(scaleX: 2.5, y: 2.5)
        aiv.transform = transfrom
        aiv.startAnimating()
        return aiv
    }()
    
    lazy var pauseButton: UIButton = {
        let button = UIButton(type: .system)
        let imagePause = UIImage(named: "pause")
        button.setImage(imagePause, for: .normal)
        button.tintColor = .white
        button.isHidden = true
        button.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        return button
    }()
    
    let videoLengthLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00:00"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .right
        return label
    }()
    
    let currentTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00:00"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        return label
    }()
    
    lazy var videoSlider: UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = .red
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        return slider
    }()
    
    @objc func handleSliderChange() {
        
        if let duration = player?.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            
            let value = Float64(videoSlider.value) * totalSeconds
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            player?.seek(to: seekTime, completionHandler: { (completedSeek) in
                
            })
        }
    }
    
    @objc func handlePause() {
       
        if isPlaying {
            pauseButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            player?.pause()
        } else {
            pauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            player?.play()
        }
        
        isPlaying = !isPlaying
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        setupPlayer()
        assemble()
        //setupGradientLayer()
        
        displayTimeisHidden()
        tapToDisplay()
    }
    
    private func tapToDisplay() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tap)
    }
    
    @objc func fireTimer() {
        controlsContainerView.isHidden = true
    }
    
    @objc func handleTap() {
        controlsContainerView.isHidden = false
        displayTimeisHidden()
    }
    
    private func displayTimeisHidden() {
        _ = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: false)
    }
    
    private func assemble() {
        addSubview(controlsContainerView)
        controlsContainerView.addSubview(activityIndicatorView)
        controlsContainerView.addSubview(pauseButton)
        controlsContainerView.addSubview(videoLengthLabel)
        controlsContainerView.addSubview(videoSlider)
        controlsContainerView.addSubview(currentTimeLabel)
        setupLayout()
    }
    
    private func setupLayout() {
        controlsContainerView.frame = frame
        
        activityIndicatorView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        pauseButton.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        videoLengthLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview()
            make.width.equalTo(70)
            make.height.equalTo(30)
        }
        
        videoSlider.snp.makeConstraints { (make) in
            make.right.equalTo(videoLengthLabel.snp.left)
            make.top.bottom.equalTo(videoLengthLabel)
            make.left.equalTo(currentTimeLabel.snp.right)
        }
        
        currentTimeLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.bottom.equalToSuperview()
            make.width.equalTo(70)
            make.height.equalTo(30)
        }
    }
    
    private func setupPlayer() {
        let videoURL = URL(string: "http://devstreaming.apple.com/videos/wwdc/2016/102w0bsn0ge83qfv7za/102/hls_vod_mvp.m3u8")
        if let urlString = videoURL {
            player = AVPlayer(url: urlString)
            let playerLayer = AVPlayerLayer(player: player)

            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            player?.play()
        
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            
            // track player progress
            let interval = CMTime(value: 1, timescale: 2)
            player?.addPeriodicTimeObserver(forInterval: interval, queue: nil, using: { (progressTime) in
            let second = CMTimeGetSeconds(progressTime)
            
                let secs = Int(second)
                
                self.currentTimeLabel.text = NSString(format: "%02d:%02d:%02d", secs/3600, (secs % 3600)/60, (secs % 3600)%60) as String
                
                //lets move the slider
                
                if let duration = self.player?.currentItem?.duration {
                    let durationSeconds = CMTimeGetSeconds(duration)
                    
                    self.videoSlider.value = Float(second / durationSeconds)
                }
            })
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndicatorView.stopAnimating()
            controlsContainerView.backgroundColor = .clear
            pauseButton.isHidden = false
            
            if let duration = player?.currentItem?.duration {
                let seconds = CMTimeGetSeconds(duration)
                
                let secs = Int(seconds)
                videoLengthLabel.text = NSString(format: "%02d:%02d:%02d", secs/3600, (secs % 3600)/60, (secs % 3600)%60) as String
            }
        }
    }
    
    private func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.7, 1.2]
        
        controlsContainerView.layer.addSublayer(gradientLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoLauncer: NSObject {
    func showVideoPlayer() {
        
        if let keyWindow = UIApplication.shared.keyWindow {
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = .white
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            
            // 16 * 9 is the aspect ratio of all HD videos
            let height = keyWindow.frame.width * 9 / 16
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
            let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
            view.addSubview(videoPlayerView)
            
            keyWindow.addSubview(view)
            
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                view.frame = keyWindow.frame
            }) { (completedAnimation) in
                 UIApplication.shared.isStatusBarHidden = true
            }
        }
    }
}
