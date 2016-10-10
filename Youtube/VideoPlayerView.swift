//
//  VideoPlayerView.swift
//  Youtube
//
//  Created by Erkam Kucet on 09/10/2016.
//  Copyright © 2016 Erkam Kucet. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
  
  let activityIndicatorView: UIActivityIndicatorView = {
    
    let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    aiv.translatesAutoresizingMaskIntoConstraints = false
    aiv.startAnimating()
    return aiv
  }()
  
  let controlsContainerView: UIView = {
    
    let view = UIView()
    view.backgroundColor = UIColor(white: 0, alpha: 1)
    return view
  }()
  
  lazy var pausePlayButton: UIButton = {
    
    let button = UIButton(type: .system)
    let image = UIImage(named: "pause")
    button.setImage(image, for: .normal)
    button.tintColor = UIColor.white
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
    button.isHidden = true
    return button
  }()
  
  let videoLenghtLabel: UILabel = {
  
    let label = UILabel()
    label.text = "00:00"
    label.textColor = .white
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.boldSystemFont(ofSize: 13)
    label.textAlignment = .right
    
    return label
  }()
  
  let currentTimeLabel: UILabel = {
  
    let label = UILabel()
    label.text = "00:00"
    label.textColor = .white
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.boldSystemFont(ofSize: 13)
    label.textAlignment = .left
    
    return label
  }()
  
  lazy var videoSlider: UISlider = {
  
    let slider = UISlider()
    slider.translatesAutoresizingMaskIntoConstraints = false
    slider.minimumTrackTintColor = .red
    slider.setThumbImage(UIImage(named: "thumb"), for: .normal)
    slider.maximumTrackTintColor = .white
    slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
    
    return slider
  }()
  
  var player: AVPlayer?
  
  var isPlaying = false
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupPlayerView()
    setupGradientLayer()
    controlsContainerView.frame = frame
    
    addSubview(controlsContainerView)
    
    controlsContainerView.addSubview(activityIndicatorView)
    activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    
    controlsContainerView.addSubview(pausePlayButton)
    
    pausePlayButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    pausePlayButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    pausePlayButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
    pausePlayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
    controlsContainerView.addSubview(currentTimeLabel)
    currentTimeLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
    currentTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    currentTimeLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
    currentTimeLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
    
    controlsContainerView.addSubview(videoLenghtLabel)
    
    videoLenghtLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
    videoLenghtLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    videoLenghtLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
    videoLenghtLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
    
    controlsContainerView.addSubview(videoSlider)
    videoSlider.rightAnchor.constraint(equalTo: videoLenghtLabel.leftAnchor).isActive = true
    videoSlider.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    videoSlider.leftAnchor.constraint(equalTo: currentTimeLabel.rightAnchor, constant: -8).isActive = true
    videoSlider.heightAnchor.constraint(equalToConstant: 30).isActive = true
    
    backgroundColor = UIColor.black
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupPlayerView(){
    
    let urlString = "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726"
    if let url = URL(string: urlString){
      
      player = AVPlayer(url: url)
      
      let playerLayer = AVPlayerLayer(player: player)
      self.layer.addSublayer(playerLayer)
      playerLayer.frame = self.frame
      
      player?.play()
      player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
      
      let interval = CMTime(value: 1, timescale: 2)
      player?.addPeriodicTimeObserver(forInterval: interval, queue: .main, using: { (progressTime) in
        
        let seconds = CMTimeGetSeconds(progressTime)
        let secondsString = String(format: "%02d", (Int(seconds) % 60))
        let minutesString = String(format: "%02d", Int(seconds / 60))
        self.currentTimeLabel.text = "\(minutesString):\(secondsString)"
        
        if let duration = self.player?.currentItem?.duration{
        
          let durationSeconds = CMTimeGetSeconds(duration)
          self.videoSlider.value = Float(seconds / durationSeconds)
        }
      })
    }
  }
  
  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    
    if keyPath == "currentItem.loadedTimeRanges"{
      
      activityIndicatorView.stopAnimating()
      controlsContainerView.backgroundColor = UIColor.clear
      pausePlayButton.isHidden = false
      isPlaying = true
      
      if let duration = player?.currentItem?.duration{
      
        let second = CMTimeGetSeconds(duration)
        let secondText = Int(second) % 60
        let minutesText = String(format: "%02d", Int(second) / 60)
        videoLenghtLabel.text = "\(minutesText):\(secondText)"
      }
    }
  }
  
  func handlePause(){
    
    if isPlaying{
    
      player?.pause()
      pausePlayButton.setImage(UIImage(named: "play"), for: .normal)
    }else{
    
      player?.play()
      pausePlayButton.setImage(UIImage(named: "pause"), for: .normal)
    }
    
    isPlaying = !isPlaying
  }
  
  func handleSliderChange(){
  
    if let duration = player?.currentItem?.duration{
    
      let totalSecond = CMTimeGetSeconds(duration)
      let value = Float64(videoSlider.value) * totalSecond
      let seekTime = CMTime(value: Int64(value), timescale: 1)
      player?.seek(to: seekTime, completionHandler: { (completedSeek) in

      })
    }
  }
  
  private func setupGradientLayer(){
  
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = bounds
    gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
    gradientLayer.locations = [0.7, 1.2]
    controlsContainerView.layer.addSublayer(gradientLayer)
  }
}

