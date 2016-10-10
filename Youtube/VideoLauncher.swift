//
//  VideoLauncher.swift
//  Youtube
//
//  Created by Erkam Kucet on 08/10/2016.
//  Copyright © 2016 Erkam Kucet. All rights reserved.
//

import UIKit

class VideoLauncher: NSObject {
  
  func showVideoPlayer(){
  
    print("Play video")
    
    if let keyWindow = UIApplication.shared.keyWindow{
    
      let view = UIView(frame: keyWindow.frame)
      view.backgroundColor = UIColor.white
      view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
      
      let height = keyWindow.frame.width * 9 / 16
      let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
      let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
      view.addSubview(videoPlayerView)
      
      keyWindow.addSubview(view)
      
      UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
        
        view.frame = keyWindow.frame
        }, completion: { (complatedanimation) in
          
          UIApplication.shared.isStatusBarHidden = true
      })
    }
  }
}
