//
//  MainTabBarController.swift
//  ApplaudoStudioTextAniList
//
//  Created by Israel Gutierrez on 03/06/17.
//  Copyright © 2017 Israel Gutierrez. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
  
  override func viewDidLoad() {
    
    UINavigationBar.appearance().isTranslucent = true
    UINavigationBar.appearance().tintColor = UtilityManager.sharedInstance.backGroundColorApp
    
    super.viewDidLoad()
    
  }
  
}
