//
//  CustomTextFieldWithTitleView.swift
//  ApplaudoStudioTextAniList
//
//  Created by Alejandro Aristi C on 03/06/17.
//  Copyright © 2017 Israel Gutierrez. All rights reserved.
//

import UIKit

protocol CustomTextFieldWithTitleViewDelegate {
  
  func customTextFieldSelected(sender: CustomTextFieldWithTitleView)
  
}

class CustomTextFieldWithTitleView: UIView, UITextFieldDelegate {
  
  private var textOfTitleString: String?
  private var nameOfImageString: String?
  private var colorOfLabelsAndLines: UIColor?
  private var positionFromTop: CGFloat?
  private var positionFromLeft: CGFloat?
  private var iconImageView: UIImageView?
  private var titleLabel: UILabel?
  var mainTextField: UITextField! = nil
  
  var delegate: CustomTextFieldWithTitleViewDelegate?
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect, title: String?, image: String?, colorOfLabelAndLine: UIColor?) {
    
    textOfTitleString = title
    nameOfImageString = image
    colorOfLabelsAndLines = colorOfLabelAndLine
    
    super.init(frame: frame)
    self.initInterface()
    
  }
  
  init(frame: CGRect, title: String?, image: String?, colorOfLabelAndLine: UIColor?, positionInYInsideView: CGFloat?, positionInXInsideView: CGFloat?) {
    
    textOfTitleString = title
    nameOfImageString = image
    colorOfLabelsAndLines = colorOfLabelAndLine
    positionFromTop = positionInYInsideView
    positionFromLeft = positionInXInsideView
    
    super.init(frame: frame)
    self.initInterface()
    
  }
  
  private func initInterface() {
    
    self.createTitleLabel()
    self.createIconImageView()
    
    self.createMainTextField()
    
  }
  
  private func createTitleLabel() {
    
    if textOfTitleString != nil {
      
      titleLabel = UILabel.init(frame: CGRect.zero)
      
      let font = UIFont.init(name: "SFUIText-Light",
                             size: 14.0 * UtilityManager.sharedInstance.conversionWidth)
      
      var color = UtilityManager.sharedInstance.labelsAndLinesColor
      
      if colorOfLabelsAndLines != nil {
        
        color = colorOfLabelsAndLines!
        
      }
      
      let style = NSMutableParagraphStyle()
      style.alignment = NSTextAlignment.center
      
      let stringWithFormat = NSMutableAttributedString(
        string: textOfTitleString!,
        attributes:[NSFontAttributeName:font!,
                    NSParagraphStyleAttributeName:style,
                    NSForegroundColorAttributeName:color
        ]
      )
      titleLabel!.attributedText = stringWithFormat
      titleLabel!.sizeToFit()
      
      var newFrame = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                                 y: 0.0 * UtilityManager.sharedInstance.conversionHeight,
                                 width: titleLabel!.frame.size.width,
                                 height: titleLabel!.frame.size.height)
      
      if positionFromTop != nil {
        
        newFrame = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: positionFromTop!,
                               width: titleLabel!.frame.size.width,
                               height: titleLabel!.frame.size.height)
        
      }
      
      if positionFromLeft != nil {
        
        newFrame = CGRect.init(x: positionFromLeft!,
                               y: newFrame.origin.y,
                               width: titleLabel!.frame.size.width,
                               height: titleLabel!.frame.size.height)
        
      }
      
      titleLabel!.frame = newFrame
      self.addSubview(titleLabel!)
    }
    
  }
  
  private func createIconImageView() {
    
    let positionY: CGFloat
    
    if titleLabel != nil {
      
      positionY = titleLabel!.frame.origin.y + titleLabel!.frame.size.height + (29.0 * UtilityManager.sharedInstance.conversionHeight) //When has title but not icon
      
    } else {
      
      positionY = 29.0 * UtilityManager.sharedInstance.conversionHeight //When doesn't have an title but icon
      
    }
    
    
    if nameOfImageString != nil {
      
      iconImageView = UIImageView.init(image: UIImage.init(named: nameOfImageString!))
      let iconImageViewFrame = CGRect.init(x: 2.0 * UtilityManager.sharedInstance.conversionWidth,
                                           y: positionY,
                                           width: iconImageView!.frame.size.width,
                                           height: iconImageView!.frame.size.height)
      
      iconImageView!.frame = iconImageViewFrame
      
      self.addSubview(iconImageView!)
      
    }
    
    
  }
  
  private func createMainTextField() {
    
    var newPositionX: CGFloat
    var newPositionXForLine: CGFloat
    var newPositionY: CGFloat
    var newWidth: CGFloat
    var newWidthForLine: CGFloat
    
    if iconImageView != nil {
      
      newPositionX = iconImageView!.frame.origin.x + iconImageView!.frame.size.width + (20.0 * UtilityManager.sharedInstance.conversionWidth)
      
      newWidth = (self.frame.size.width) - (iconImageView!.frame.origin.x + iconImageView!.frame.size.width + (20.0 * UtilityManager.sharedInstance.conversionWidth))
      
      newWidthForLine = newPositionX + newWidth
      
      newPositionXForLine = -newPositionX
      
      
    } else {
      
      newPositionX = 4.0 * UtilityManager.sharedInstance.conversionWidth
      
      if positionFromLeft != nil {
        
        newPositionX = positionFromLeft!
        
      }
      
      newWidth = self.frame.size.width
      
      newPositionXForLine = -4.0 * UtilityManager.sharedInstance.conversionWidth
      
      newWidthForLine = self.frame.size.width
      
      if positionFromLeft != nil {
        
        newWidth = self.frame.size.width - (positionFromLeft! * 2.0)
        newWidthForLine = self.frame.size.width - (positionFromLeft! * 2.0)
        
      }
      
    }
    
    if titleLabel != nil {
      
      newPositionY = titleLabel!.frame.origin.y + titleLabel!.frame.size.height + (0.0 * UtilityManager.sharedInstance.conversionHeight)
      
    } else {
      
      newPositionY = 7.0 * UtilityManager.sharedInstance.conversionHeight
      
    }
    
    let frameForTextField = CGRect.init(x: newPositionX,
                                        y: newPositionY,
                                        width: newWidth,
                                        height: 30.0 * UtilityManager.sharedInstance.conversionHeight)
    
    mainTextField = UITextField.init(frame: frameForTextField)
    
    mainTextField.backgroundColor = UIColor.clear
    
    var colorOfLine = UtilityManager.sharedInstance.labelsAndLinesColor
    
    if colorOfLabelsAndLines != nil {
      
      colorOfLine = colorOfLabelsAndLines!
      
    }
    
    let border = CALayer()
    let width = CGFloat(0.5)
    border.borderColor = colorOfLine.cgColor
    border.borderWidth = width
    border.frame = CGRect.init(x: newPositionXForLine,
                               y: mainTextField.frame.size.height + (1.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: newWidthForLine,
                               height: 0.5)
    mainTextField.layer.masksToBounds = false
    mainTextField.layer.addSublayer(border)
    mainTextField.clearButtonMode = UITextFieldViewMode.whileEditing
    mainTextField.font = UIFont.systemFont(ofSize: 13.5 * UtilityManager.sharedInstance.conversionHeight)
    mainTextField.delegate = self
    self.addSubview(mainTextField)
    
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    
    self.delegate?.customTextFieldSelected(sender: self)
    
  }
  
}
