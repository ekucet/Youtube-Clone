//
//  Setting.swift
//  Youtube
//
//  Created by Erkam Kucet on 07/10/2016.
//  Copyright © 2016 Erkam Kucet. All rights reserved.
//

import UIKit

class Setting: NSObject{
  
  let name: SettingName
  let imageName: String
  
  init(name: SettingName, imageName: String) {
    
    self.name = name
    self.imageName = imageName
  }
}

enum SettingName: String{

  case Cancel = "Cancel"
  case Setting = "Settings"
  case Terms = "Terms & privacy policy"
  case Feedback = "Send Feedback"
  case Help = "Help"
  case Account = "Switch Account"
  
}
