//
//  SerieViewCell.swift
//  ApplaudoStudioTextAniList
//
//  Created by Israel Gutierrez on 16/07/17.
//  Copyright © 2017 Israel Gutierrez. All rights reserved.
//

import UIKit

class SerieViewCell: UICollectionViewCell {
  
  private var image: UIImageView! = nil
  private var nameLabel: UILabel! = nil
  private var japaneseNameLabel: UILabel! = nil
  private var averageScoreLabel: UILabel! = nil
  private var totalEpisodesLabel: UILabel! = nil
  private var serieInfo: Serie! = nil
  
  func setSerieInfo(newInfo: Serie) {
    
    self.serieInfo = newInfo
    self.setImage()
    self.setNameLabel()
    self.setJapaneseNameLabel()
    self.setAverageScoreLabel()
    self.setTotalEpisodesLabel()
    
  }
  
  private func setImage() {
    
    if image != nil {
      
      image.removeFromSuperview()
      image = nil
      
    }
    
    let frameForImage = CGRect.init(x: 5.0 * UtilityManager.sharedInstance.conversionWidth,
                                    y: 5.0 * UtilityManager.sharedInstance.conversionHeight,
                                width: 56.0 * UtilityManager.sharedInstance.conversionWidth,
                               height: 78.0 * UtilityManager.sharedInstance.conversionHeight)
    
    image = UIImageView.init(frame: frameForImage)
    
    if serieInfo.urlLargeImage != "" {
    
      image.imageFromUrl(urlString: serieInfo.urlLargeImage)
      
    }
    
    self.addSubview(image)
    
  }
  
  private func setNameLabel() {
    
    if nameLabel != nil {
      
      nameLabel.removeFromSuperview()
      nameLabel = nil
      
    }
    
    let frameForLabel = CGRect.init(x: image.frame.origin.x + image.frame.size.width + (5.0 * UtilityManager.sharedInstance.conversionWidth),
                                    y: 5.0 * UtilityManager.sharedInstance.conversionHeight,
                                width: self.frame.size.width - (image.frame.size.width + (10.0 * UtilityManager.sharedInstance.conversionWidth)),
                               height: 40.0 * UtilityManager.sharedInstance.conversionHeight)
    
    nameLabel = UILabel.init(frame: frameForLabel)
    nameLabel.numberOfLines = 4
    nameLabel.lineBreakMode = .byWordWrapping
    
    let font = UIFont(name: "AppleSDGothicNeo-Light",
                      size: 11.0 * UtilityManager.sharedInstance.conversionWidth)
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
    
    self.addSubview(nameLabel)
    
  }
  
  private func setJapaneseNameLabel() {
    
    if japaneseNameLabel != nil {
      
      japaneseNameLabel.removeFromSuperview()
      japaneseNameLabel = nil
      
    }
    
    let frameForLabel = CGRect.init(x: image.frame.origin.x + image.frame.size.width + (5.0 * UtilityManager.sharedInstance.conversionWidth),
                                    y: nameLabel.frame.origin.y + nameLabel.frame.size.height + (5.0 * UtilityManager.sharedInstance.conversionHeight),
                                    width: self.frame.size.width - (image.frame.size.width + (15.0 * UtilityManager.sharedInstance.conversionWidth)),
                                    height: 45.0 * UtilityManager.sharedInstance.conversionHeight)
    
    japaneseNameLabel = UILabel.init(frame: frameForLabel)
    japaneseNameLabel.numberOfLines = 3
    japaneseNameLabel.lineBreakMode = .byWordWrapping
    
    let font = UIFont(name: "AppleSDGothicNeo-Light",
                      size: 10.5 * UtilityManager.sharedInstance.conversionWidth)
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
    
    japaneseNameLabel.attributedText = stringWithFormat
    
    self.addSubview(japaneseNameLabel)
    
  }
  
  private func setAverageScoreLabel() {
    
    if averageScoreLabel != nil {
      
      averageScoreLabel.removeFromSuperview()
      averageScoreLabel = nil
      
    }
    
    let frameForLabel = CGRect.init(x: (5.0 * UtilityManager.sharedInstance.conversionWidth),
                                    y: image.frame.origin.y + image.frame.size.height + (5.0 * UtilityManager.sharedInstance.conversionHeight),
                                    width: self.frame.size.width - (image.frame.size.width + (15.0 * UtilityManager.sharedInstance.conversionWidth)),
                                    height: self.frame.size.height - (nameLabel.frame.size.height + japaneseNameLabel.frame.size.height + (15.0 * UtilityManager.sharedInstance.conversionHeight)))
    
    averageScoreLabel = UILabel.init(frame: frameForLabel)
    averageScoreLabel.numberOfLines = 0
    averageScoreLabel.lineBreakMode = .byWordWrapping
    
    let font = UIFont(name: "AppleSDGothicNeo-Light",
                      size: 10.0 * UtilityManager.sharedInstance.conversionWidth)
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
    
    averageScoreLabel.attributedText = stringWithFormat
    
    self.addSubview(averageScoreLabel)
    
  }
  
  private func setTotalEpisodesLabel() {
    
    if totalEpisodesLabel != nil {
      
      totalEpisodesLabel.removeFromSuperview()
      totalEpisodesLabel = nil
      
    }
    
    let frameForLabel = CGRect.init(x: averageScoreLabel.frame.origin.x + averageScoreLabel.frame.size.width + (5.0 * UtilityManager.sharedInstance.conversionWidth),
                                    y: image.frame.origin.y + image.frame.size.height + (5.0 * UtilityManager.sharedInstance.conversionHeight),
                                    width: self.frame.size.width - (image.frame.size.width + (15.0 * UtilityManager.sharedInstance.conversionWidth)),
                                    height: self.frame.size.height - (nameLabel.frame.size.height + japaneseNameLabel.frame.size.height + (15.0 * UtilityManager.sharedInstance.conversionHeight)))
    
    totalEpisodesLabel = UILabel.init(frame: frameForLabel)
    totalEpisodesLabel.numberOfLines = 0
    totalEpisodesLabel.lineBreakMode = .byWordWrapping
    
    let font = UIFont(name: "AppleSDGothicNeo-Light",
                      size: 10.0 * UtilityManager.sharedInstance.conversionWidth)
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
    
    self.addSubview(totalEpisodesLabel)
    
  }
  
}
