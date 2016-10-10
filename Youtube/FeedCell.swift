//
//  FeedCell.swift
//  Youtube
//
//  Created by Erkam Kucet on 08/10/2016.
//  Copyright © 2016 Erkam Kucet. All rights reserved.
//

import UIKit

class FeedCell: BaseCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

  private let  cellId = "cellID"
  
  var videos: [Video]?
  
  lazy var collectionView: UICollectionView = {
  
    let layout = UICollectionViewFlowLayout()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = UIColor.white
    collectionView.delegate = self
    collectionView.dataSource = self
    
    return collectionView
  }()
  
  override func setupViews() {
    super.setupViews()
    
    fetchVideos()
    backgroundColor = .brown
    
    addSubview(collectionView)
    
    addConstraintWithFormat(format: "H:|[v0]|", views: collectionView)
    addConstraintWithFormat(format: "V:|[v0]|", views: collectionView)
    
    collectionView.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
  }
  
  func fetchVideos(){
    
    ApiService.sharedInstance.fetchVideos { (videos: [Video]) in
      
      self.videos = videos
      self.collectionView.reloadData()
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return videos?.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! VideoCell
    
    cell.video = videos?[indexPath.item]
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let height = (frame.width - 16 - 16) * 9 / 16
    return CGSize(width: frame.width, height: height + 16 + 88)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    
    return 0
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    let videoLauncher = VideoLauncher()
    videoLauncher.showVideoPlayer()
  }

}
