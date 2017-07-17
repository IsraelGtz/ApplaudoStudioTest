//
//  SerieDetailViewController.swift
//  ApplaudoStudioTextAniList
//
//  Created by Israel Gutierrez on 17/07/17.
//  Copyright © 2017 Israel Gutierrez. All rights reserved.
//

import UIKit

class SerieDetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
  private var mainScrollView: UIScrollView! = nil
  private var nameLabel: UILabel! = nil
  private var nameJapaneseLabel: UILabel! = nil
  private var imagesCollectionView: UICollectionView! = nil
  private var scoreLabel: UILabel! = nil
  private var totalEpisodesLabel: UILabel! = nil
  private var descriptionLabel: UILabel! = nil
  private var serieInfo: Serie! = nil
  private var arrayOfImages: Array<String>! = Array<String>()
  
  private let cellImagesID = "cellImagesID"
  
  init(newSerieInfo: Serie) {
    
    serieInfo = newSerieInfo
    
    super.init(nibName: nil, bundle: nil)
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    
    self.view = UIView.init(frame: UIScreen.main.bounds)
    self.view.backgroundColor = UIColor.white
    self.navigationController?.navigationBar.isHidden = false
    
  }
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    arrayOfImages = [serieInfo.urlSmallImage, serieInfo.urlMediumImage, serieInfo.urlLargeImage, serieInfo.urlBannerImage]
    
    ServerManager.sharedInstance.requestForGetInformationFromAnEspecificSerie(id: serieInfo.serieId, actionsToMakeWhenSucceeded: { (serieDescription) in
      
      print(serieDescription)
      self.serieInfo.description = serieDescription
      
      self.initInterface()
      
    }, actionsToMakeWhenFailed: {
    
      self.initInterface()
    
    })
    
  }
  
  private func initInterface() {
    
    self.initMainScrollView()
    self.initNameLabel()
    self.initNameJapaneseLabel()
    self.initImagesCollectionView()
    self.initScoreLabel()
    self.initTotalEpisodesLabel()
    self.initDescriptionLabel()
    
  }
  
  private func initMainScrollView() {
    
    if mainScrollView != nil {
      
      mainScrollView.removeFromSuperview()
      mainScrollView = nil
      
    }
    
    let frameForScroll = CGRect.init(x: 0.0,
                                     y: 0.0,
                                 width: UIScreen.main.bounds.size.width,
                                height: UIScreen.main.bounds.size.height)
    
    mainScrollView = UIScrollView.init(frame: frameForScroll)
    
    let newContentSize = CGSize.init(width: mainScrollView.frame.size.width,
                                     height: mainScrollView.frame.size.height + (200.0 * UtilityManager.sharedInstance.conversionHeight))
    
    mainScrollView.contentSize = newContentSize
    self.view.addSubview(mainScrollView)
    
  }
  
  private func initNameLabel() {
    
    if nameLabel != nil {
      
      nameLabel.removeFromSuperview()
      nameLabel = nil
      
    }
    
    let frameForLabel = CGRect.init(x: 10.0 * UtilityManager.sharedInstance.conversionWidth,
                                    y: 60.0 * UtilityManager.sharedInstance.conversionHeight,
                                width: mainScrollView.frame.size.width - (20.0 * UtilityManager.sharedInstance.conversionWidth),
                               height: 40.0 * UtilityManager.sharedInstance.conversionHeight)
    
    nameLabel = UILabel.init(frame: frameForLabel)
    nameLabel.numberOfLines = 2
    nameLabel.lineBreakMode = .byWordWrapping
    
    let font = UIFont(name: "AppleSDGothicNeo-Light",
                      size: 22.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.black
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.left
    
    let stringWithFormat = NSMutableAttributedString(
      string: serieInfo.titleRomaji,
      attributes:[NSFontAttributeName: font!,
                  NSParagraphStyleAttributeName: style,
                  NSForegroundColorAttributeName: color
      ]
    )
    
    nameLabel.attributedText = stringWithFormat
    
    mainScrollView.addSubview(nameLabel)
    
  }
  
  private func initNameJapaneseLabel() {
    
    if nameJapaneseLabel != nil {
      
      nameJapaneseLabel.removeFromSuperview()
      nameJapaneseLabel = nil
      
    }
    
    let frameForLabel = CGRect.init(x: 10.0 * UtilityManager.sharedInstance.conversionWidth,
                                    y: nameLabel.frame.origin.y + nameLabel.frame.size.height,
                                    width: mainScrollView.frame.size.width - (20.0 * UtilityManager.sharedInstance.conversionWidth),
                                    height: 40.0 * UtilityManager.sharedInstance.conversionHeight)
    
    nameJapaneseLabel = UILabel.init(frame: frameForLabel)
    nameJapaneseLabel.numberOfLines = 2
    nameJapaneseLabel.lineBreakMode = .byWordWrapping
    
    let font = UIFont(name: "AppleSDGothicNeo-Light",
                      size: 18.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.lightGray
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.left
    
    let stringWithFormat = NSMutableAttributedString(
      string: serieInfo.titleJapanese,
      attributes:[NSFontAttributeName: font!,
                  NSParagraphStyleAttributeName: style,
                  NSForegroundColorAttributeName: color
      ]
    )
    
    nameJapaneseLabel.attributedText = stringWithFormat
    
    mainScrollView.addSubview(nameJapaneseLabel)
    
  }
  
  private func initImagesCollectionView() {
    
    if imagesCollectionView != nil {
      
      imagesCollectionView.removeFromSuperview()
      imagesCollectionView = nil
      
    }
    
    let frameForCollection = CGRect.init(x: 15.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: nameJapaneseLabel.frame.origin.y + nameJapaneseLabel.frame.size.height + (30.0 * UtilityManager.sharedInstance.conversionHeight),
                                         width: self.view.frame.size.width - (30.0 * UtilityManager.sharedInstance.conversionWidth),
                                         height: 150.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let layout = UICollectionViewFlowLayout.init()
    layout.scrollDirection = .horizontal
    imagesCollectionView = UICollectionView.init(frame: frameForCollection, collectionViewLayout: layout)
    imagesCollectionView.register(ImageViewCell.self, forCellWithReuseIdentifier: cellImagesID)
    imagesCollectionView.backgroundColor = UIColor.white
    imagesCollectionView.delegate = self
    imagesCollectionView.dataSource = self
    
    self.mainScrollView.addSubview(imagesCollectionView)
    
  }
  
  private func initScoreLabel() {
    
    if scoreLabel != nil {
      
      scoreLabel.removeFromSuperview()
      scoreLabel = nil
      
    }
    
    let frameForLabel = CGRect.init(x: (15.0 * UtilityManager.sharedInstance.conversionWidth),
                                    y: imagesCollectionView.frame.origin.y + imagesCollectionView.frame.size.height + (15.0 * UtilityManager.sharedInstance.conversionHeight),
                                    width: 100.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: 15.0 * UtilityManager.sharedInstance.conversionHeight)
    
    scoreLabel = UILabel.init(frame: frameForLabel)
    scoreLabel.numberOfLines = 0
    scoreLabel.lineBreakMode = .byWordWrapping
    
    let font = UIFont(name: "AppleSDGothicNeo-Light",
                      size: 12.5 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.darkGray
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.left
    
    let stringWithFormat = NSMutableAttributedString(
      string: "Score: " + serieInfo.averageScore,
      attributes:[NSFontAttributeName: font!,
                  NSParagraphStyleAttributeName: style,
                  NSForegroundColorAttributeName: color
      ]
    )
    
    scoreLabel.attributedText = stringWithFormat
    
    mainScrollView.addSubview(scoreLabel)
    
  }
  
  private func initTotalEpisodesLabel() {
    
    if totalEpisodesLabel != nil {
      
      totalEpisodesLabel.removeFromSuperview()
      totalEpisodesLabel = nil
      
    }
    
    let frameForLabel = CGRect.init(x: scoreLabel.frame.origin.x + scoreLabel.frame.size.width + (35.0 * UtilityManager.sharedInstance.conversionWidth),
                                    y: scoreLabel.frame.origin.y,
                                width: 100.0 * UtilityManager.sharedInstance.conversionWidth,
                               height: 15.0 * UtilityManager.sharedInstance.conversionHeight)
    
    totalEpisodesLabel = UILabel.init(frame: frameForLabel)
    totalEpisodesLabel.numberOfLines = 0
    totalEpisodesLabel.lineBreakMode = .byWordWrapping
    
    let font = UIFont(name: "AppleSDGothicNeo-Light",
                      size: 12.5 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.darkGray
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.left
    
    let stringWithFormat = NSMutableAttributedString(
      string: "Episodes: " + serieInfo.totalEpisodes,
      attributes:[NSFontAttributeName: font!,
                  NSParagraphStyleAttributeName: style,
                  NSForegroundColorAttributeName: color
      ]
    )
    
    totalEpisodesLabel.attributedText = stringWithFormat
    
    mainScrollView.addSubview(totalEpisodesLabel)
    
  }
  
  private func initDescriptionLabel() {
    
    if descriptionLabel != nil {
      
      descriptionLabel.removeFromSuperview()
      descriptionLabel = nil
      
    }
    
    let frameForLabel = CGRect.init(x: (15.0 * UtilityManager.sharedInstance.conversionWidth),
                                    y: imagesCollectionView.frame.origin.y + imagesCollectionView.frame.size.height + (45.0 * UtilityManager.sharedInstance.conversionHeight),
                                width: mainScrollView.frame.size.width - (30.0 * UtilityManager.sharedInstance.conversionWidth),
                               height: CGFloat.greatestFiniteMagnitude)
    
    descriptionLabel = UILabel.init(frame: frameForLabel)
    descriptionLabel.numberOfLines = 0
    descriptionLabel.lineBreakMode = .byWordWrapping
    
    let font = UIFont(name: "AppleSDGothicNeo-Light",
                      size: 11.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.black
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.justified
    
    let stringWithFormat = NSMutableAttributedString(
      string: serieInfo.description.replacingOccurrences(of: "<br>", with: "").replacingOccurrences(of: "<i>", with: "").replacingOccurrences(of: "</i>", with: ""),
      attributes:[NSFontAttributeName: font!,
                  NSParagraphStyleAttributeName: style,
                  NSForegroundColorAttributeName: color
      ]
    )
    
    descriptionLabel.attributedText = stringWithFormat
    descriptionLabel.sizeToFit()
    
    descriptionLabel.frame = CGRect.init(x: (15.0 * UtilityManager.sharedInstance.conversionWidth),
                                         y: imagesCollectionView.frame.origin.y + imagesCollectionView.frame.size.height + (45.0 * UtilityManager.sharedInstance.conversionHeight),
                                         width: descriptionLabel.frame.size.width,
                                         height: descriptionLabel.frame.size.height)
    
    mainScrollView.addSubview(descriptionLabel)
    
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return arrayOfImages.count
    
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize.init(width: 125.0 * UtilityManager.sharedInstance.conversionWidth,
                       height: collectionView.frame.size.height)
    
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellImagesID, for: indexPath) as! ImageViewCell
    cell.setImage(newUrl: arrayOfImages[indexPath.row])
    cell.backgroundColor = UIColor.white
    
    return cell
    
  }
  
  
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    
    super.viewWillTransition(to: size, with: coordinator)
    
    coordinator.animate(alongsideTransition: nil) { (coordinator) in
      
      if UIDevice.current.orientation.isLandscape {
        
        print("Landscape")
        UtilityManager.sharedInstance.deviceRotated()
        self.initInterface()
        
      } else {
        
        print("Portrait")
        UtilityManager.sharedInstance.deviceRotated()
        self.initInterface()
        
      }
      
    }
    
  }
  
  
}
