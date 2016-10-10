//
//  ViewController.swift
//  Youtube
//
//  Created by Erkam Kucet on 05/10/2016.
//  Copyright © 2016 Erkam Kucet. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

  private let cellId = "cellID"
  private let trendingCellId = "trendingCellID"
  private let subscriptonCellId = "subscriptonCellID"
  
  private let titles = ["Home", "Trending","Subscribtions","Account"]
  
  lazy var menuBar: MenuBar = {
    
    let mb = MenuBar()
    mb.homeController = self
    return mb
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()

    navigationController?.navigationBar.isTranslucent = false
    
    let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
    titleLabel.text = "Home"
    titleLabel.textColor = UIColor.white
    titleLabel.font = UIFont.systemFont(ofSize: 20)
    navigationItem.titleView = titleLabel
    
    collectionView?.backgroundColor = UIColor.white
    collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
    collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
    collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
    
    setupCollectionView()
    setupMenuBar()
    setupNavBarButtons()
  }
  
  func setupCollectionView(){
    
    if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
    
      flowLayout.scrollDirection = .horizontal
      flowLayout.minimumLineSpacing = 0
    }
  
    collectionView?.backgroundColor = UIColor.white
    collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
    collectionView?.register(TrendingCell.self, forCellWithReuseIdentifier: trendingCellId)
    collectionView?.register(SubscriptonCell.self, forCellWithReuseIdentifier: subscriptonCellId)
    collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
    collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
    collectionView?.isPagingEnabled = true
  }
  
  private func setupMenuBar(){
  
    navigationController?.hidesBarsOnSwipe = true
    let redView = UIView()
    redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
    view.addSubview(redView)
    view.addConstraintWithFormat(format: "H:|[v0]|", views: redView)
    view.addConstraintWithFormat(format: "V:[v0(50)]", views: redView)
    view.addSubview(menuBar)
    view.addConstraintWithFormat(format: "H:|[v0]|", views: menuBar)
    view.addConstraintWithFormat(format: "V:[v0(50)]", views: menuBar)
    menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
  }
  
  private func setupNavBarButtons(){
  
    let searchImage = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
    let searchButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
    
    let moreImage = UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal)
    let moreButtonItem = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handleMore))
    
    navigationItem.rightBarButtonItems = [moreButtonItem, searchButtonItem]
  }
  
  func handleSearch(){
  
    scrollToMenuIndex(menuIndex: 2)
  }
  
  func scrollToMenuIndex(menuIndex: Int){
  
    let indexPath = NSIndexPath(item: menuIndex, section: 0)
    collectionView?.scrollToItem(at: indexPath as IndexPath, at: .centeredHorizontally, animated: true)
    setTitleForIndex (indexPath: indexPath)
  }

  lazy var settingsLauncher: SettingsLauncher = {
  
    let launcher = SettingsLauncher()
    launcher.homeController = self
    return launcher
  }()
  
  func handleMore(){
    
    settingsLauncher.showSettings()
  }
  
  func showControllerForSettings(setting: Setting){
  
    let dummySettingsViewController = UIViewController()
    dummySettingsViewController.view.backgroundColor = UIColor.white
    dummySettingsViewController.navigationItem.title = setting.name.rawValue
    navigationController?.navigationBar.tintColor = UIColor.white
    navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
    navigationController?.pushViewController(dummySettingsViewController, animated: true)
  }
  
  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
    menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
  }
  
  override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    
    let indexPath = NSIndexPath(item: Int(targetContentOffset.pointee.x / view.frame.width), section: 0)
    menuBar.collectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: .centeredHorizontally)
    setTitleForIndex(indexPath: indexPath)
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 4
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let identifier:String
    if indexPath.item == 1{
      identifier = trendingCellId
    }else if indexPath.item == 2{
      identifier = subscriptonCellId
    }else{
      identifier = cellId
    }
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
    
    return cell

  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(width: view.frame.width, height: view.frame.height - 50)
  }
  
  private func setTitleForIndex(indexPath: NSIndexPath){
  
    if let titleLabel = navigationItem.titleView as? UILabel{
      
      titleLabel.text = titles[indexPath.item]
    }
  }

}

