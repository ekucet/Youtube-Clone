//
//  VideoCell.swift
//  Youtube
//
//  Created by Erkam Kucet on 06/10/2016.
//  Copyright © 2016 Erkam Kucet. All rights reserved.
//

import UIKit

class VideoCell: BaseCell {
  
  var video: Video?{
  
    didSet{
    
      setupThumbnailImage()
      setupProfileImage()
      
      titleLabel.text = video?.title
      
      if let channelName = video?.channel?.name, let numberOfViews = video?.number_of_views{
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
      
        let subtitleText = "\(channelName) - \(numberFormatter.string(from: numberOfViews)!) - 2 years ago"
        subTitleTextView.text = subtitleText
      }
      
      if let title = video?.title{
      
        let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 14)], context: nil)
        
        if estimatedRect.size.height > 20{
        
          titleLabelHeightConstraint?.constant = 44
        }else{
        
          titleLabelHeightConstraint?.constant = 20
        }
      }
    }
  }
  
  func setupThumbnailImage(){
  
    if let thumbnailImageURL = video?.thumbnail_image_name{
    
      self.thumbnailImageView.loadImageUsingURLString(urlString: thumbnailImageURL)
    }
  }
  
  func setupProfileImage(){
  
    if let profileImageURL = video?.channel?.profile_image_name {
      
      self.userProfileImageView.loadImageUsingURLString(urlString: profileImageURL)
    }
  }
  
  let thumbnailImageView: CustomImageView = {
    
    let imageView = CustomImageView()
    imageView.image = UIImage(named: "taylor_swift_blank_space")
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    return imageView
  }()
  
  let separatorView: UIView = {
    
    let view = UIView()
    view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
    return view
  }()
  
  let userProfileImageView: CustomImageView = {
    
    let imageView = CustomImageView()
    imageView.image = UIImage(named: "taylor_swift_profile")
    imageView.layer.cornerRadius = 22
    imageView.layer.masksToBounds = true
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  let titleLabel: UILabel = {
    
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Taylor Swift - Blank Space"
    label.numberOfLines = 2
    return label
  }()
  
  let subTitleTextView: UITextView = {
    
    let textView = UITextView()
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.text = "TaylorSwiftVEVO - 1,604,684,607 views - 2 years ago"
    textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
    textView.textColor = UIColor.lightGray
    return textView
  }()
  
  var titleLabelHeightConstraint: NSLayoutConstraint?
  
  override func setupViews(){
    super.setupViews()
    
    addSubview(thumbnailImageView)
    addSubview(separatorView)
    addSubview(userProfileImageView)
    addSubview(titleLabel)
    addSubview(subTitleTextView)
    
    //thumbnailImageView Constraints
    addConstraintWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
    addConstraintWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views: thumbnailImageView, userProfileImageView, separatorView)
    
    //separatorView Constraints
    addConstraintWithFormat(format: "H:|[v0]|", views: separatorView)
    
    //userProfileImageView Constraints
    addConstraintWithFormat(format: "H:|-16-[v0(44)]", views: userProfileImageView)
    
    //Top Constraints
    addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1.0, constant: 8))
    
    //Left Constraints
    addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1.0, constant: 8))
    
    //Right Constraint
    addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1.0, constant: 0.0))
    
    //Height Constraint
    titleLabelHeightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.0, constant: 44.0)
    addConstraint(titleLabelHeightConstraint!)
    addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.0, constant: 44.0))
    
    //Top Constraints
    addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1.0, constant: 4))
    
    //Left Constraints
    addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1.0, constant: 8))
    
    //Right Constraint
    addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1.0, constant: 0.0))
    
    //Height Constraint
    addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.0, constant: 30.0))
  }
}
