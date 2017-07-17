//
//  TypeOfAnimesViewCell.swift
//  ApplaudoStudioTextAniList
//
//  Created by Alejandro Aristi C on 09/07/17.
//  Copyright © 2017 Israel Gutierrez. All rights reserved.
//

import UIKit

class TypeOfAnimeViewCell: UICollectionViewCell {
  
  override init(frame: CGRect) {
    
    super.init(frame: frame)
    self.setInterface()
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setInterface() {
    
    self.backgroundColor = UIColor.black
    
  }
  
}
