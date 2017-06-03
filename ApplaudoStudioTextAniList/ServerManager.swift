//
//  ServerManager.swift
//  ApplaudoStudioTextAniList
//
//  Created by Alejandro Aristi C on 03/06/17.
//  Copyright © 2017 Israel Gutierrez. All rights reserved.
//

import Foundation
import Alamofire

class ServerManager: NSObject {
  
  static let sharedInstance = ServerManager()
  
  static let developmentServer = ""
  static let productionServer  = "https://anilist.co/api/"
  let typeOfServer = developmentServer
  
  func requestToLogin(mail: String, password: String, actionsToMakeWhenSucceeded: @escaping (_ json: [String: AnyObject]) -> Void, actionsToMakeWhenFailed: @escaping () -> Void) {
    
    let urlToRequest = "http://devfactura.in/api/movil/login"  //This is the only one which is different
    
    var requestConnection = URLRequest.init(url: NSURL.init(string: urlToRequest)! as URL)
    requestConnection.httpMethod = "POST"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let params = ["email": mail,
                  "password": password,
                  "api_key": "XjWJpwEPy2ks23Kh"
    ]
    
    do {
      
      let _ = requestConnection.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
      
      Alamofire.request(requestConnection)
        .validate(statusCode: 200..<400)
        .responseJSON{ response in
          if response.response?.statusCode == 200 {
            
            let json = try! JSONSerialization.jsonObject(with: response.data!, options: [])
            print(json)
            
            UserDefaults.standard.set(mail, forKey: UtilityManager.sharedInstance.kLastValidUserEmail)
            UserDefaults.standard.set(password, forKey: UtilityManager.sharedInstance.kLastValidUserPassword)
            
            actionsToMakeWhenSucceeded(json as! [String: AnyObject])
            
          } else {
            
            if response.response?.statusCode == 400 {
              
              let json = try! JSONSerialization.jsonObject(with: response.data!, options: []) as! NSDictionary
              
              let message = (json["message"] as? String != nil ? json["message"] as! String : "")
              
              if message != "" {
                
                let alertController = UIAlertController(title: "ERROR",
                                                        message: message,
                                                        preferredStyle: UIAlertControllerStyle.alert)
                
                let cancelAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
                  
                  actionsToMakeWhenFailed()
                  
                }
                alertController.addAction(cancelAction)
                
                let actualController = UtilityManager.sharedInstance.currentViewController()
                actualController.present(alertController, animated: true, completion: nil)
                
              } else {
                
                actionsToMakeWhenFailed()
                
              }
              
            } else {
              
              let alertController = UIAlertController(title: "ERROR",
                                                      message: "Error de conexión con el servidor, favor de intentar más tarde",
                                                      preferredStyle: UIAlertControllerStyle.alert)
              
              let cancelAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
                
                actionsToMakeWhenFailed()
                
              }
              alertController.addAction(cancelAction)
              
              let actualController = UtilityManager.sharedInstance.currentViewController()
              actualController.present(alertController, animated: true, completion: nil)
              
            }
            
          }
          
      }
      
    } catch(_) {
      
      let alertController = UIAlertController(title: "ERROR",
                                              message: "Error de conexión con el servidor, favor de intentar más tarde",
                                              preferredStyle: UIAlertControllerStyle.alert)
      
      let cancelAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
        
        actionsToMakeWhenFailed()
        
      }
      alertController.addAction(cancelAction)
      
      let actualController = UtilityManager.sharedInstance.currentViewController()
      actualController.present(alertController, animated: true, completion: nil)
      
    }
    
    
  }

  func requestAuthorizationCode(actionsToMakeWhenSucceeded: @escaping () -> Void, actionsToMakeWhenFailed: @escaping () -> Void) {
    
    let urlToRequest = "\(typeOfServer)/auth/authorize"
    
    let params: [String: AnyObject] = [
      
      "grant_type":    "authorization_code" as AnyObject,
      "client_id":     "merol666-wcuef" as AnyObject,
      "redirect_uri":  "" as AnyObject,
      "response_type": "code" as AnyObject
      
    ]
    
    var requestConnection = URLRequest.init(url: NSURL.init(string: urlToRequest)! as URL)
    requestConnection.httpMethod = "GET"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    do {
      
      let _ = requestConnection.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
      
      Alamofire.request(requestConnection)
        .validate(statusCode: 200..<400)
        .responseJSON{ response in
          if response.response?.statusCode == 200 {
            
            let json = try! JSONSerialization.jsonObject(with: response.data!, options: [])
            print(json)
            
               actionsToMakeWhenSucceeded()
            
          } else {
            
            print("Response status code in Facturas: \(response.response?.statusCode)")
            
            if response.response?.statusCode == 400 {
              
              do {
                
                let json = try JSONSerialization.jsonObject(with: response.data!, options: [])
                
                if json as? NSDictionary != nil {
                  
                  let message = (json as! NSDictionary)["status"] as? String != nil ? (json as! NSDictionary)["status"] as! String : ""
                  
                  if message == "No se encontraron datos correspondientes a tu búsqueda" {
                    
                    actionsToMakeWhenSucceeded()
                    
                  }
                  
                  
                }
                
              } catch(_) {
                
                let alertController = UIAlertController(title: "ERROR",
                                                        message: "Connection error with server. Try again later.",
                                                        preferredStyle: UIAlertControllerStyle.alert)
                
                let cancelAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
                  
                  actionsToMakeWhenFailed()
                  
                }
                alertController.addAction(cancelAction)
                
                let actualController = UtilityManager.sharedInstance.currentViewController()
                actualController.present(alertController, animated: true, completion: nil)
                
              }
              
            }
            
            actionsToMakeWhenFailed()
            
          }
      }
      
    } catch(_) {
      
      let alertController = UIAlertController(title: "ERROR",
                                              message: "Connection error with server. Try again later.",
                                              preferredStyle: UIAlertControllerStyle.alert)
      
      let cancelAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
        
        actionsToMakeWhenFailed()
        
      }
      alertController.addAction(cancelAction)
      
      let actualController = UtilityManager.sharedInstance.currentViewController()
      actualController.present(alertController, animated: true, completion: nil)
      
    }
    
  }
  

  
  
}

