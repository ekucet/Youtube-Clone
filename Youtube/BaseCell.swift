//
//  BaseCell.swift
//  Youtube
//
//  Created by Erkam Kucet on 06/10/2016.
//  Copyright © 2016 Erkam Kucet. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupViews(){
    
  }
}
