//
//  SettingsLauncher.swift
//  Youtube
//
//  Created by Erkam Kucet on 07/10/2016.
//  Copyright © 2016 Erkam Kucet. All rights reserved.
//

import UIKit

class SettingsLauncher: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
  let blackView = UIView()
  
  private let cellId = "cellID"
  let cellHeight: CGFloat = 50
  var homeController: HomeController?
  
  let settings: [Setting] = {
    
    let cancelSetting = Setting(name: .Cancel, imageName: "cancel")
    let settingsSetting = Setting(name: .Setting, imageName: "settings")
    let termsSetting = Setting(name: .Terms, imageName: "privacy")
    let feedbackSetting = Setting(name: .Feedback, imageName: "feedback")
    let helpSetting = Setting(name: .Help, imageName: "help")
    let accountSetting = Setting(name: .Account, imageName: "switch_account")
    
    return [settingsSetting, termsSetting, feedbackSetting, helpSetting, accountSetting, cancelSetting]
  }()
  
  let collectionView: UICollectionView = {
  
    let layout = UICollectionViewFlowLayout()
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.backgroundColor = UIColor.white
    
    return cv
  }()
  
  override init() {
    super.init()
    
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(SettingsCell.self, forCellWithReuseIdentifier: cellId)
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return settings.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingsCell
    let setting = settings[indexPath.item]
    cell.setting = setting
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(width: collectionView.frame.width, height: cellHeight)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    let setting = settings[indexPath.item]
    handleDismiss(setting: setting)
  }
  
  func showSettings(){

    if let window = UIApplication.shared.keyWindow{
      
      blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
      
      blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
      
      window.addSubview(blackView)
      window.addSubview(collectionView)
      
      let height: CGFloat = CGFloat(settings.count) * cellHeight
      let y = window.frame.height - height
      
      collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
      
      blackView.frame = window.frame
      blackView.alpha = 0
      
      UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
        
        self.blackView.alpha = 1
        self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
        
        }, completion: nil)
    }
  }
  
  func handleDismiss(setting: Setting){
    
    UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
      
      self.blackView.alpha = 0
      
      if let window = UIApplication.shared.keyWindow{
        
        self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
      }
    }) { (completed) in
      
      if setting.name != .Cancel{
        
        self.homeController?.showControllerForSettings(setting: setting)
      }
    }
  }
}
