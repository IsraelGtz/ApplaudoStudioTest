//
//  ServerManager.swift
//  ApplaudoStudioTextAniList
//
//  Created by Israel Gutierrez on 03/06/17.
//  Copyright © 2017 Israel Gutierrez. All rights reserved.
//

import Foundation
import Alamofire
import p2_OAuth2
import SafariServices

class ServerManager: NSObject {
  
  static let sharedInstance = ServerManager()
  
  static let developmentServer = ""
  static let productionServer  = "https://anilist.co/api/"
  var alamofireManager: SessionManager! = SessionManager()
  let typeOfServer = productionServer

  func requestAuthorizationCode(actionsToMakeWhenSucceeded: @escaping () -> Void, actionsToMakeWhenFailed: @escaping () -> Void) {
    
    let urlToRequest = "\(typeOfServer)auth/authorize"
    
    let params: [String: AnyObject] = [
      
      "grant_type": "authorization_code" as AnyObject,
      "client_id": "merol666-wcuef" as AnyObject,
      "client_secret": "1m5WVcHbWciJpGndoVJxdqfnD" as AnyObject,
      "redirect_uri": ["iOSApplaudoTest://"] as AnyObject,
      "response_type": "code" as AnyObject,
      "scope": "user repo:status" as AnyObject,
      "secret_in_body": true as AnyObject,                                      // GitHub does not accept client secret in the Authorization header
      "verbose": true as AnyObject

      
    ]
    
    let oauth2 = OAuth2CodeGrant(settings: [
      "grant_type": "authorization_code",
      "client_id": "merol666-wcuef",
      "client_secret": "1m5WVcHbWciJpGndoVJxdqfnD",
      "redirect_uri": ["iOSApplaudoTest://"],
      "response_type": "code",
      "scope": "user repo:status",
      "secret_in_body": true,                                      // GitHub does not accept client secret in the Authorization header
      "verbose": true
          
      ] as OAuth2JSON)
      
  
    
//    let safariController = SFSafariViewController.init(url: URL)
    
    oauth2.authConfig.authorizeEmbedded = true
//    oauth2.authConfig.authorizeContext = safariController
    
    let sessionManager = SessionManager()
    let retrier = OAuth2RetryHandler(oauth2: oauth2)
    sessionManager.adapter = retrier
    sessionManager.retrier = retrier
    self.alamofireManager = sessionManager   // you must hold on to this somewhere
    
    sessionManager.request(urlToRequest).validate().responseJSON { response in
      debugPrint(response)
    }
    
    
    
    
    var requestConnection = URLRequest.init(url: NSURL.init(string: urlToRequest)! as URL)
    requestConnection.httpMethod = "GET"
//    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
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
            
            print("\(response.response?.statusCode)")
            
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
  
  func requestForAccessToken(actionsToMakeWhenSucceeded: @escaping (_ newAccessToken: String) -> Void, actionsToMakeWhenFailed: @escaping () -> Void) {

    let urlToRequest = "\(typeOfServer)auth/access_token"
    
    let params = [
      
      "grant_type"   : "client_credentials",
      "client_id"    : "merol666-wcuef",
      "client_secret": "1m5WVcHbWciJpGndoVJxdqfnD",
      
    ]
    
    var requestConnection = URLRequest.init(url: NSURL.init(string: urlToRequest)! as URL)
    requestConnection.httpMethod = "POST"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    do {
      
      let _ = requestConnection.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
      
      Alamofire.request(requestConnection)
        .validate(statusCode: 200..<400)
        .responseJSON{ response in
          if response.response?.statusCode == 200 {
            
            let json = try! JSONSerialization.jsonObject(with: response.data!, options: []) as! [String: AnyObject]
            print(json)
            
            let accessToken = json["access_token"] as? String != nil ? json["access_token"] as! String : "no access token"
            
            actionsToMakeWhenSucceeded(accessToken)
            
          } else {
            
            if response.response?.statusCode == 400 {
              
              do {
                
                let json = try JSONSerialization.jsonObject(with: response.data!, options: [])
                
                if json as? NSDictionary != nil {
                  
                  let message = (json as! NSDictionary)["status"] as? String != nil ? (json as! NSDictionary)["status"] as! String : ""
                  
                  if message == "error" {
                    
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
  
  func requestForGetAllSeries(actionsToMakeWhenSucceeded: @escaping (_ series: Array<Serie>) -> Void, actionsToMakeWhenFailed: @escaping () -> Void) {
    
    let urlToRequest = "\(typeOfServer)user/displayname/animelist?access_token=\(UserManager.Session.accessToken)"
    
    var requestConnection = URLRequest.init(url: NSURL.init(string: urlToRequest)! as URL)
    requestConnection.httpMethod = "GET"
    
    Alamofire.request(requestConnection)
      .validate(statusCode: 200..<400)
      .responseJSON{ response in
        if response.response?.statusCode == 200 {
          
          do {
            
            let json = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String: AnyObject]
            
            let seriesCompleted = json["lists"] as? [String: AnyObject] != nil ? json["lists"] as! [String: AnyObject] : [String: AnyObject]()
            let arrayOfAllSeriesCompleted = seriesCompleted["completed"] as? Array<[String: AnyObject]> != nil ? seriesCompleted["completed"] as! Array<[String: AnyObject]> : Array<[String: AnyObject]>()
            
            var allTheSeries: Array<Serie> = Array<Serie>()
            
            for serie in arrayOfAllSeriesCompleted {
              
              let serieInfo = serie["anime"] as? [String: AnyObject] != nil ? serie["anime"] as! [String: AnyObject] : [String: AnyObject]()
              
              let newId = serieInfo["id"] as? Int != nil ? String(serieInfo["id"] as! Int) : "-1"
              let newTitleRomaji = serieInfo["title_romaji"] as? String != nil ? serieInfo["title_romaji"] as! String : "No title in romaji"
              let newTitleJapanese = serieInfo["title_japanese"] as? String != nil ? serieInfo["title_japanese"] as! String : "No title in japanese"
              let newType = serieInfo["type"] as? String != nil ? serieInfo["type"] as! String : "No type"
              let newAdult = serieInfo["adult"] as? Bool != nil ? serieInfo["adult"] as! Bool : false
              let newAverageScore = serieInfo["average_score"] as? Double != nil ? String(serieInfo["average_score"] as! Double) : "0.0"
              let newUrlSmallImage = serieInfo["image_url_sml"] as? String != nil ? serieInfo["image_url_sml"] as! String : ""
              let newUrlMediumImage = serieInfo["image_url_med"] as? String != nil ? serieInfo["image_url_med"] as! String : ""
              let newUrlLargeImage = serieInfo["image_url_lge"] as? String != nil ? serieInfo["image_url_lge"] as! String : ""
              let newUrlBannerImage = serieInfo["image_url_banner"] as? String != nil ? serieInfo["image_url_banner"] as! String : ""
              let newTotalEpisodes = serieInfo["total_episodes"] as? Int != nil ? String(serieInfo["total_episodes"] as! Int) : "NA"
              let newGenres = serieInfo["genres"] as? [String] != nil ? serieInfo["genres"] as! [String] : [String]()
              let newFinishedAiring = serieInfo["airing_status"] as? String != nil ? serieInfo["airing_status"] as! String : "NA"
              let newDescription = serieInfo["description"] as? String != nil ? serieInfo["description"] as! String : "No Information"
              
              let newSerie = Serie.init(newSerieId: newId,
                                        newTitleRomaji: newTitleRomaji,
                                        newTitleJapanese: newTitleJapanese,
                                        newAverageScore: newAverageScore,
                                        newTotalEpisodes: newTotalEpisodes,
                                        newUrlSmallImage: newUrlSmallImage,
                                        newUrlMediumImage: newUrlMediumImage,
                                        newUrlLargeImage: newUrlLargeImage,
                                        newUrlBannerImage: newUrlBannerImage,
                                        newType: newType,
                                        newFinishedAiring: newFinishedAiring,
                                        newGenres: newGenres,
                                        newAdult: newAdult,
                                        newDescription: newDescription)
              
              allTheSeries.append(newSerie)
              
            }
            
            actionsToMakeWhenSucceeded(allTheSeries)
            
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
          
        } else {
          
          if response.response?.statusCode == 400 {
            
            do {
              
              let json = try JSONSerialization.jsonObject(with: response.data!, options: [])
              
              if json as? NSDictionary != nil {
                
                let message = (json as! NSDictionary)["status"] as? String != nil ? (json as! NSDictionary)["status"] as! String : ""
                
                if message == "error" {
                  
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
          
          actionsToMakeWhenFailed()
          
        }
    }
    
  }
  
  
  func requestForGetInformationFromAnEspecificSerie(id: String, actionsToMakeWhenSucceeded: @escaping (_ serieDescription: String) -> Void, actionsToMakeWhenFailed: @escaping () -> Void) {
    
    let urlToRequest = "\(typeOfServer)anime/\(id)?access_token=\(UserManager.Session.accessToken)"
    
    var requestConnection = URLRequest.init(url: NSURL.init(string: urlToRequest)! as URL)
    requestConnection.httpMethod = "GET"
    
    Alamofire.request(requestConnection)
      .validate(statusCode: 200..<400)
      .responseJSON{ response in
        if response.response?.statusCode == 200 {
          
          do {
            
            let json = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String: AnyObject]
            

            let newDescription = json["description"] as? String != nil ? json["description"] as! String : "No Information"
              


            
            actionsToMakeWhenSucceeded(newDescription)
            
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
          
        } else {
          
          if response.response?.statusCode == 400 {
            
            do {
              
              let json = try JSONSerialization.jsonObject(with: response.data!, options: [])
              
              if json as? NSDictionary != nil {
                
                let message = (json as! NSDictionary)["status"] as? String != nil ? (json as! NSDictionary)["status"] as! String : ""
                
                if message == "error" {
                  
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
          
          actionsToMakeWhenFailed()
          
        }
    }
    
  }

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  

  
}

