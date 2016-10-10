//
//  ApiService.swift
//  Youtube
//
//  Created by Erkam Kucet on 08/10/2016.
//  Copyright © 2016 Erkam Kucet. All rights reserved.
//

import UIKit

enum FetchVideoULRs: String{
  
  case homeVideos = "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json"
  case trendingVideos = "https://s3-us-west-2.amazonaws.com/youtubeassets/trending.json"
  case subscriptionVideos = "https://s3-us-west-2.amazonaws.com/youtubeassets/subscriptions.json"
}

class ApiService: NSObject {
  
  static let sharedInstance = ApiService()
  
  func fetchVideos(completion: @escaping ([Video]) -> ()){
  
    fetchFeedForUrlString(url: .homeVideos, completion: completion)
  }
  
  func fetchTrendingFeed(completion: @escaping ([Video]) -> ()){
  
    fetchFeedForUrlString(url: .trendingVideos, completion: completion)
  }
  
  func fetchSubscription(completion: @escaping ([Video]) -> ()){
  
    fetchFeedForUrlString(url: .subscriptionVideos, completion: completion)
  }
  
  func fetchFeedForUrlString(url: FetchVideoULRs, completion: @escaping ([Video]) -> ()){
  
    let url = URL(string: url.rawValue)
    URLSession.shared.dataTask(with: url!) { (data, response, error) in
      
      if error != nil{
        
        print(error?.localizedDescription)
        return
      }
      
      do{
        
        if let unwrappedData = data, let jsonDictionaries = try JSONSerialization.jsonObject(with: unwrappedData, options: .mutableContainers)  as? [[String:AnyObject]]{
          
          DispatchQueue.main.async(execute: {
            completion(jsonDictionaries.map({return Video(dictionary: $0)}))
          })
        }
        
      }catch let jSonError{
        
        print(jSonError.localizedDescription)
      }
      
      }.resume()
  }
}
