//
//  MenuCell.swift
//  Youtube
//
//  Created by Erkam Kucet on 06/10/2016.
//  Copyright © 2016 Erkam Kucet. All rights reserved.
//

import UIKit

class MenuCell: BaseCell {
  
  let imageView: UIImageView = {
    
    let iv = UIImageView()
    iv.image = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
    iv.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
    
    return iv
  }()
  
  override var isHighlighted: Bool{
  
    didSet{
    
      imageView.tintColor = isHighlighted ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13)
    }
  }
  
  override var isSelected: Bool{
  
    didSet{
    
      imageView.tintColor = isSelected ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13)
    }
  }
  
  override func setupViews() {
    super.setupViews()
    
    addSubview(imageView)
    addConstraintWithFormat(format: "H:[v0(28)]", views: imageView)
    addConstraintWithFormat(format: "V:[v0(28)]", views: imageView)
    
    addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0))
    addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0))
  }
}

