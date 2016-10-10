//
//  SettingsCell.swift
//  Youtube
//
//  Created by Erkam Kucet on 07/10/2016.
//  Copyright © 2016 Erkam Kucet. All rights reserved.
//

import UIKit

class SettingsCell: BaseCell {
  
  override var isHighlighted: Bool{
  
    didSet{
    
      backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
      nameLabel.textColor = isHighlighted ? UIColor.white: UIColor.black
      iconImageView.tintColor = isHighlighted ? UIColor.white: UIColor.gray
    }
  }
  
  let nameLabel: UILabel = {
  
    let label = UILabel()
    label.text = "Settings"
    
    return label
  }()
  
  let iconImageView: UIImageView = {
  
    let imageView = UIImageView()
    imageView.image = UIImage(named: "settings")
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  var setting: Setting?{
  
    didSet{
    
      nameLabel.text = setting?.name.rawValue
      
      if let imageName = setting?.imageName{
      
        iconImageView.image = UIImage(named: (imageName))?.withRenderingMode(.alwaysTemplate)
        iconImageView.tintColor = UIColor.darkGray
      }
    }
  }
  
  override func setupViews() {
    super.setupViews()
   
    addSubview(nameLabel)
    addSubview(iconImageView)
    
    addConstraintWithFormat(format: "H:|-8-[v0(30)]-8-[v1]|", views: iconImageView, nameLabel)
    addConstraintWithFormat(format: "V:|[v0]|", views: nameLabel)
    addConstraintWithFormat(format: "V:[v0(30)]", views: iconImageView)
    
    addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
  }
}
