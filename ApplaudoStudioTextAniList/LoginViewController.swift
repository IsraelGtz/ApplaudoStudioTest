//
//  LoginViewController.swift
//  ApplaudoStudioTextAniList
//
//  Created by Israel Gutierrez on 03/06/17.
//  Copyright © 2017 Israel Gutierrez. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
  
  private var mainTabBarController: MainTabBarController! = nil
  private var logoImageView: UIImageView! = nil
  private var emailTextField: CustomTextFieldWithTitleView! = nil
  private var passwordTextField: CustomTextFieldWithTitleView! = nil
  private var loginButton: UIButton! = nil
  
  override func loadView() {
    
    self.view = UIView.init(frame: UIScreen.main.bounds)
    self.view.backgroundColor = UIColor.white //UIColor.init(patternImage: UIImage.init(named: "fondo_login")!)
    
//    let backgroundImageName = ""
    
//    if UtilityManager.sharedInstance.isIpad() == true {
//      
//      backgroundImageName = ""
//      
//    }
    
//    let imageViewBackground = UIImageView.init(image: UIImage.init(named: backgroundImageName)!)
//    imageViewBackground.contentMode = .scaleToFill
//    imageViewBackground.frame = self.view.frame
//    self.view.addSubview(imageViewBackground)
    
    self.initInterface()
    
  }
  
  private func initInterface() {
    
    self.editNavigationBar()
    
    self.createLogo()
    self.createEmailTextField()
    self.createPasswordTextField()
    self.createLoginButton()
    
  }
  
  private func editNavigationBar() {
    
    self.title = "Atrás"
    self.navigationController?.isNavigationBarHidden = true
    
  }
  
  private func createLogo() {
    
    logoImageView = UIImageView.init(image: UIImage.init(named: ""))
    let goldenPitchStarFrame = CGRect.init(x: (self.view.frame.size.width / 2.0) - (80.0 * UtilityManager.sharedInstance.conversionWidth),
                                           y: (20.0 * UtilityManager.sharedInstance.conversionHeight),
                                           width: 160.0 * UtilityManager.sharedInstance.conversionWidth,
                                           height: 104.35 * UtilityManager.sharedInstance.conversionHeight)
    logoImageView.frame = goldenPitchStarFrame
    
    self.view.addSubview(logoImageView)
    
  }
  
  private func createEmailTextField() {
    
    var positionInY = logoImageView.frame.origin.y + logoImageView.frame.size.height + (19.65 * UtilityManager.sharedInstance.conversionHeight)
    
    if UtilityManager.sharedInstance.isIpad() {
      
      positionInY = logoImageView.frame.origin.y + logoImageView.frame.size.height + (300.00 - UIApplication.shared.statusBarFrame.size.height) * UtilityManager.sharedInstance.conversionHeight
      
    }
    
    
    let frameOfView = CGRect.init(x: 20.0 * UtilityManager.sharedInstance.conversionWidth,
                                  y: positionInY,
                                  width: UIScreen.main.bounds.size.width - (36.0 * UtilityManager.sharedInstance.conversionWidth),
                                  height: 47.0 * UtilityManager.sharedInstance.conversionHeight)
    
    emailTextField = CustomTextFieldWithTitleView.init(frame: frameOfView,
                                                       title: ConstantsTextOfViewControllers.LoginViewController.emailTextFieldDescriptionText,
                                                       image: nil,
                                                       colorOfLabelAndLine: UIColor.white)
    emailTextField.mainTextField.textColor = UIColor.white
    emailTextField.mainTextField.autocapitalizationType = .none
    
    self.view.addSubview(emailTextField)
    
  }
  
  private func createPasswordTextField() {
    
    let frameOfView = CGRect.init(x: 20.0 * UtilityManager.sharedInstance.conversionWidth,
                                  y: emailTextField.frame.origin.y + emailTextField.frame.size.height + (15.0 * UtilityManager.sharedInstance.conversionWidth),
                                  width: UIScreen.main.bounds.size.width - (36.0 * UtilityManager.sharedInstance.conversionWidth),
                                  height: 47.0 * UtilityManager.sharedInstance.conversionHeight)
    
    passwordTextField = CustomTextFieldWithTitleView.init(frame: frameOfView,
                                                          title: ConstantsTextOfViewControllers.LoginViewController.passwordTextFieldDescriptionText,
                                                          image: nil,
                                                          colorOfLabelAndLine: UIColor.white)
    passwordTextField.mainTextField.textColor = UIColor.white
    passwordTextField.mainTextField.isSecureTextEntry = true
    
    self.view.addSubview(passwordTextField)
    
  }
  
  private func createLoginButton() {
    
    loginButton = UIButton.init(frame: CGRect.zero)
    
    let font = UIFont.systemFont(ofSize: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.white
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.center
    
    let stringWithFormat = NSMutableAttributedString(
      string: ConstantsTextOfViewControllers.LoginViewController.loginButtonText,
      attributes:[NSFontAttributeName: font,
                  NSParagraphStyleAttributeName: style,
                  NSForegroundColorAttributeName: color
      ]
    )
    
    loginButton.backgroundColor = UIColor.orange
    loginButton.setBackgroundColor(color: UIColor.init(red: 255.0/255.0, green: 164.0/255.0, blue: 78.0/255.0, alpha: 1.0), forState: .highlighted)
    
    loginButton.setAttributedTitle(stringWithFormat, for: .normal)
    loginButton.addTarget(self,
                          action: #selector(loginButtonPressed),
                          for: .touchUpInside)
    loginButton.sizeToFit()
    
    let frameForButton = CGRect.init(x: 20.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: passwordTextField.frame.origin.y + passwordTextField.frame.size.height + (20.0 * UtilityManager.sharedInstance.conversionHeight),
                                     width: UIScreen.main.bounds.size.width - (40.0 * UtilityManager.sharedInstance.conversionWidth),
                                     height: 44.0 * UtilityManager.sharedInstance.conversionHeight)
    
    loginButton.frame = frameForButton
    
    self.view.addSubview(loginButton)
    
  }
  
  @objc private func loginButtonPressed() {
    
    if UtilityManager.sharedInstance.isValidEmail(testStr: emailTextField.mainTextField.text!) == false {
      
      let alertController = UIAlertController(title: "ERROR",
                                              message: "Write a valid email",
                                              preferredStyle: UIAlertControllerStyle.alert)
      
      let cancelAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in }
      alertController.addAction(cancelAction)
      
      self.present(alertController, animated: true, completion: nil)
      
    } else
      if passwordTextField.mainTextField.text?.isEmpty == true || UtilityManager.sharedInstance.isValidText(testString: passwordTextField.mainTextField.text!) == false {
        
        let alertController = UIAlertController(title: "ERROR",
                                                message: "You have to write a password",
                                                preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in }
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
      } else {
        
//        UtilityManager.sharedInstance.showLoader()
//        
//        ServerManager.sharedInstance.requestToLogin(mail: emailTextField.mainTextField.text!,
//                                                    password: passwordTextField.mainTextField.text!,
//                                                    actionsToMakeWhenSucceeded: { (json) in
//                                                      
//                                                      UtilityManager.sharedInstance.hideLoader()
//                                                      
//                                                      self.initAndChangeRootToMainTabBarController()
//                                                      
//        },
//                                                    actionsToMakeWhenFailed: {
//                                                      
//                                                      UtilityManager.sharedInstance.hideLoader()
//                                                      
//        })
        
    }
    
  }
  
  private func initAndChangeRootToMainTabBarController() {
    
    mainTabBarController = MainTabBarController()
    mainTabBarController.tabBar.barTintColor = UtilityManager.sharedInstance.backgroundColorForTabBar
    mainTabBarController.tabBar.isTranslucent = false
    mainTabBarController.tabBar.tintColor = UIColor.white
    
    var arrayOfViewControllers = [UINavigationController]()
    arrayOfViewControllers.append(self.createFirstBarItem())
    arrayOfViewControllers.append(self.createSecondBarItem())
    arrayOfViewControllers.append(self.createThirdBarItem())
    
    mainTabBarController.viewControllers = arrayOfViewControllers
    mainTabBarController.selectedIndex = 0
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    UIView.transition(with: appDelegate.window!,
                      duration: 0.25,
                      options: UIViewAnimationOptions.transitionCrossDissolve,
                      animations: {
                        self.view.alpha = 0.0
                        appDelegate.window?.rootViewController = self.mainTabBarController
                        appDelegate.window?.makeKeyAndVisible()
    }, completion: nil)
    
  }
  
  
  override func viewDidLoad() {
    
    
    
  }
  
  //MARK: - TabController
  
  private func createFirstBarItem() -> UINavigationController {
    
    let imageFacturasNonSelected = UIImage.init(named: "Tab_1")?.withRenderingMode(.alwaysOriginal)
    let imageFacturasSelected = UIImage.init(named: "Tab_1_on_Dark_ON")?.withRenderingMode(.alwaysOriginal)
    
    let animeListVC = ProfileViewController()
    
    let tabOneBarItem = UITabBarItem.init(title: nil,
                                          image: imageFacturasNonSelected,
                                          selectedImage: imageFacturasSelected)
    
    let newNavController = UINavigationController.init(rootViewController: animeListVC)
    newNavController.navigationBar.barTintColor = UtilityManager.sharedInstance.backGroundColorApp
    
    tabOneBarItem.tag = 1
    tabOneBarItem.imageInsets = UIEdgeInsets.init(top: tabOneBarItem.imageInsets.top + (5.0 * UtilityManager.sharedInstance.conversionHeight),
                                                  left: tabOneBarItem.imageInsets.left,
                                                  bottom: tabOneBarItem.imageInsets.bottom - (5.0 * UtilityManager.sharedInstance.conversionHeight),
                                                  right: tabOneBarItem.imageInsets.right)
    newNavController.tabBarItem = tabOneBarItem
    newNavController.navigationBar.barStyle = .black
    
    return newNavController
    
  }
  
  private func createSecondBarItem() -> UINavigationController {
    
    let imageRecibosNonSelected = UIImage.init(named: "Tab_2")?.withRenderingMode(.alwaysOriginal)
    let imageRecibosSelected = UIImage.init(named: "Tab_2_on_Dark_ON")?.withRenderingMode(.alwaysOriginal)
    
    let profileVC = ProfileViewController()
    
    let tabTwoBarItem = UITabBarItem.init(title: nil,
                                          image: imageRecibosNonSelected,
                                          selectedImage: imageRecibosSelected)
    
    let newNavController = UINavigationController.init(rootViewController: profileVC)
    newNavController.navigationBar.barTintColor = UtilityManager.sharedInstance.backGroundColorApp
    
    tabTwoBarItem.tag = 2
    tabTwoBarItem.imageInsets = UIEdgeInsets.init(top: tabTwoBarItem.imageInsets.top + (5.0 * UtilityManager.sharedInstance.conversionHeight),
                                                  left: tabTwoBarItem.imageInsets.left,
                                                  bottom: tabTwoBarItem.imageInsets.bottom - (5.0 * UtilityManager.sharedInstance.conversionHeight),
                                                  right: tabTwoBarItem.imageInsets.right)
    newNavController.tabBarItem = tabTwoBarItem
    newNavController.navigationBar.barStyle = .black
    
    return newNavController
    
  }
  
  private func createThirdBarItem() -> UINavigationController  {
    
    let imageNotasNonSelected = UIImage.init(named: "Tab_3")?.withRenderingMode(.alwaysOriginal)
    let imageNotasSelected = UIImage.init(named: "Tab_3_on_Dark_ON")?.withRenderingMode(.alwaysOriginal)
    
    let profileVC = ProfileViewController()
    
    let tabThirdBarItem = UITabBarItem.init(title: nil,
                                            image: imageNotasNonSelected,
                                            selectedImage: imageNotasSelected)
    
    let newNavController = UINavigationController.init(rootViewController: profileVC)
    newNavController.navigationBar.barTintColor = UtilityManager.sharedInstance.backGroundColorApp
    
    tabThirdBarItem.tag = 3
    tabThirdBarItem.imageInsets = UIEdgeInsets.init(top: tabThirdBarItem.imageInsets.top + (5.0 * UtilityManager.sharedInstance.conversionHeight),
                                                    left: tabThirdBarItem.imageInsets.left,
                                                    bottom: tabThirdBarItem.imageInsets.bottom - (5.0 * UtilityManager.sharedInstance.conversionHeight),
                                                    right: tabThirdBarItem.imageInsets.right)
    newNavController.tabBarItem = tabThirdBarItem
    newNavController.navigationBar.barStyle = .black
    
    return newNavController
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    
    super.viewWillAppear(animated)
    self.editNavigationBar()
    
  }
  
  
}
