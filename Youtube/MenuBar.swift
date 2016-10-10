//
//  MenuBar.swift
//  Youtube
//
//  Created by Erkam Kucet on 06/10/2016.
//  Copyright © 2016 Erkam Kucet. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  private let cellId = "cellID"
  private let imageNames = ["home", "trending", "subscriptions", "account"]
  var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
  var homeController: HomeController?
  
  lazy var collectionView: UICollectionView = {
    
    let layout = UICollectionViewFlowLayout()
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
    cv.dataSource = self
    cv.delegate = self
    
    return cv
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
    addSubview(collectionView)
    addConstraintWithFormat(format: "H:|[v0]|", views: collectionView)
    addConstraintWithFormat(format: "V:|[v0]|", views: collectionView)
    
    let selectedItemIndexPath = IndexPath(item: 0, section: 0)
    collectionView.selectItem(at: selectedItemIndexPath, animated: false, scrollPosition: .centeredHorizontally)
    setupHorizantalBar()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupHorizantalBar(){
  
    let horizantalBarView = UIView()
    horizantalBarView.backgroundColor = UIColor(white: 0.9, alpha: 1)
    horizantalBarView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(horizantalBarView)
    
    horizontalBarLeftAnchorConstraint = horizantalBarView.leftAnchor.constraint(equalTo: self.leftAnchor)
    horizontalBarLeftAnchorConstraint?.isActive = true
    horizantalBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    horizantalBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4).isActive = true
    horizantalBarView.heightAnchor.constraint(equalToConstant: 8).isActive = true
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return 4
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
    
    cell.imageView.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
    cell.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(width: frame.width / 4, height: frame.height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
//    let x = CGFloat(indexPath.item) * frame.width / 4
//    horizontalBarLeftAnchorConstraint?.constant = x
//    UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
//      
//      self.layoutIfNeeded()
//      }, completion: nil)
    
    homeController?.scrollToMenuIndex(menuIndex: indexPath.item)
  }
  
}
