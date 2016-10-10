//
//  SubscriptonCell.swift
//  Youtube
//
//  Created by Erkam Kucet on 08/10/2016.
//  Copyright © 2016 Erkam Kucet. All rights reserved.
//

import UIKit

class SubscriptonCell: FeedCell {

  override func fetchVideos() {
    
    ApiService.sharedInstance.fetchSubscription { (videos: [Video]) in
      
      self.videos = videos
      self.collectionView.reloadData()
    }
  }
}
