//
//  Video.swift
//  Youtube
//
//  Created by Erkam Kucet on 06/10/2016.
//  Copyright © 2016 Erkam Kucet. All rights reserved.
//

import UIKit

class SafeJsonObject: NSObject {
  
  override func setValue(_ value: Any?, forKey key: String) {
    let uppercasedFirstCharacter = String(key.characters.first!).uppercased()
    
    let range = key.startIndex..<key.characters.index(key.startIndex, offsetBy: 0)
    let selectorString = key.replacingCharacters(in: range, with: uppercasedFirstCharacter)
    
    let selector = NSSelectorFromString("set\(selectorString):")
    let responds = self.responds(to: selector)
    
    if !responds {
      return
    }
    
    super.setValue(value, forKey: key)
  }
}

class Video: NSObject {
  
  var thumbnail_image_name: String?
  var title: String?
  var number_of_views: NSNumber?
  var uploadDate: NSDate?
  var duration: NSNumber?
  var channel: Channel?
  
  override func setValue(_ value: Any?, forKey key: String) {
    
    if key == "channel"{
      
      let channelDictionary = value as!  [String:AnyObject]
      self.channel = Channel()
      channel?.setValuesForKeys(channelDictionary)
    }else{
      
      super.setValue(value, forKey: key)
    }
  }
  
  init(dictionary: [String:AnyObject]) {
    super.init()
    
    setValuesForKeys(dictionary)
  }
}

class Channel: NSObject {
  
  var name: String?
  var profile_image_name: String?
}
