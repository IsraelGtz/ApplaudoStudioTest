//
//  SplashViewController.swift
//  ApplaudoStudioTextAniList
//
//  Created by Alejandro Aristi C on 03/06/17.
//  Copyright © 2017 Israel Gutierrez. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

  override func loadView() {
    
    self.view = UIView.init(frame: UIScreen.main.bounds)
    self.view.backgroundColor = UIColor.black
    
  }
  
  override func viewDidLoad() {
  
    let loginViewController = LoginViewController()
    self.navigationController?.pushViewController(loginViewController, animated: true)
    
    
  }
  
  
    
    
}
