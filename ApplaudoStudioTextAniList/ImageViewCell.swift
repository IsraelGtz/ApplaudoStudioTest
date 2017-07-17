//
//  ImageViewCell.swift
//  ApplaudoStudioTextAniList
//
//  Created by Israel Gutierrez on 17/07/17.
//  Copyright © 2017 Israel Gutierrez. All rights reserved.
//

import UIKit

class ImageViewCell: UICollectionViewCell {
  
  private var image: UIImageView! = nil
  private var urlImage: String! = ""
  
  func setImage(newUrl: String) {
    
    urlImage = newUrl
    
    self.setImage()
    
  }
  
  private func setImage() {
    
    if image != nil {
      
      image.removeFromSuperview()
      image = nil
      
    }
    
    let frameForImage = CGRect.init(x: (22.5 * UtilityManager.sharedInstance.conversionWidth),
                                    y: 5.0 * UtilityManager.sharedInstance.conversionHeight,
                                    width: 80.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: 140.0 * UtilityManager.sharedInstance.conversionHeight)
    
    image = UIImageView.init(frame: frameForImage)
    self.addSubview(image)
    image.imageFromUrl(urlString: urlImage)
    
  }
  
}
