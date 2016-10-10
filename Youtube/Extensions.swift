//
//  Extensions.swift
//  Youtube
//
//  Created by Erkam Kucet on 05/10/2016.
//  Copyright © 2016 Erkam Kucet. All rights reserved.
//

import UIKit

extension UIColor{
  
  static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
    
    return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
  }
}

extension UIView{
  
  func addConstraintWithFormat(format: String, views: UIView...){
    
    var viewsDictionary = [String:UIView]()
    
    for (index, view) in views.enumerated(){
      
      let key = "v\(index)"
      view.translatesAutoresizingMaskIntoConstraints = false
      viewsDictionary[key] = view
    }
    
    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: [], metrics: nil, views: viewsDictionary))
  }
}

class CustomImageView: UIImageView {
 
  let imageCache = NSCache<AnyObject, AnyObject>()
  var imageURLString: String?
  
  func loadImageUsingURLString(urlString: String){
    
    imageURLString = urlString
    
    image = nil
    
    if let imageFromCache = imageCache.object(forKey: urlString as AnyObject){
      
      self.image = imageFromCache as? UIImage
      return
    }
    
    let url = URL(string: urlString)
    URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
      
      if error != nil{
        
        print(error?.localizedDescription)
        return
      }
      
      DispatchQueue.main.async(execute: {
        
        let imageToCache = UIImage(data: data!)
        
        if self.imageURLString == urlString{
        
          self.image = imageToCache
        }
        
        self.imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
        
        self.image = UIImage(data: data!)
      })
    }).resume()
  }

}
