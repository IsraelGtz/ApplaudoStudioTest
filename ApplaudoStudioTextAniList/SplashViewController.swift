//
//  SplashViewController.swift
//  ApplaudoStudioTextAniList
//
//  Created by Israel Gutierrez on 03/06/17.
//  Copyright © 2017 Israel Gutierrez. All rights reserved.
//

import UIKit
import CoreData

class SplashViewController: UIViewController {

  override func loadView() {
    
    self.view = UIView.init(frame: UIScreen.main.bounds)
    self.view.backgroundColor = UIColor.white
    self.navigationController?.navigationBar.isHidden = true
    
  }
  
  override func viewDidLoad() {
    
    UtilityManager.sharedInstance.showLoader()
    
    ServerManager.sharedInstance.requestForAccessToken(actionsToMakeWhenSucceeded: { (newAccessToken) in
      
      if newAccessToken != "no access token" {
        
        UserManager.Session.accessToken = newAccessToken
        
        ServerManager.sharedInstance.requestForGetAllSeries(actionsToMakeWhenSucceeded: { (arrayOfSeries) in
          
          UtilityManager.sharedInstance.hideLoader()
 
          let arrayOfNonExistingSeries = self.getNonExistentelements(arrayFromServer: arrayOfSeries, arrayFromCoreData: self.getAllSeriesFromCoreData())
          
          self.insert(arrayOfSeries: arrayOfNonExistingSeries)
          
          let allSeriesVC = AllSeriesViewController.init(newArrayOfSeries: arrayOfSeries)
          self.navigationController?.pushViewController(allSeriesVC, animated: true)
          
        }, actionsToMakeWhenFailed: {
        
          UtilityManager.sharedInstance.hideLoader()
        
          let alertController = UIAlertController(title: "ERROR",
                                                  message: "Error getting new access token. We'll try to bring info from local data base.",
                                                  preferredStyle: UIAlertControllerStyle.alert)
          
          let cancelAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            
            let arrayOfSeriesCD = self.getAllSeriesFromCoreData()
            let arrayOfSeries = self.transformFromCoreDataToNaturalSerie(arrayOfSerieCD: arrayOfSeriesCD)
            
            let allSeriesVC = AllSeriesViewController.init(newArrayOfSeries: arrayOfSeries)
            self.navigationController?.pushViewController(allSeriesVC, animated: true)
            
          }
          alertController.addAction(cancelAction)
          
          let actualController = UtilityManager.sharedInstance.currentViewController()
          actualController.present(alertController, animated: true, completion: nil)
          
        })
        
      } else {
        
        UtilityManager.sharedInstance.hideLoader()
        
        let alertController = UIAlertController(title: "ERROR",
                                                message: "Error getting new access token. We'll try to bring info from local data base.",
                                                preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
          
          let arrayOfSeriesCD = self.getAllSeriesFromCoreData()
          let arrayOfSeries = self.transformFromCoreDataToNaturalSerie(arrayOfSerieCD: arrayOfSeriesCD)
          
          let allSeriesVC = AllSeriesViewController.init(newArrayOfSeries: arrayOfSeries)
          self.navigationController?.pushViewController(allSeriesVC, animated: true)
          
        }
        alertController.addAction(cancelAction)
        
        let actualController = UtilityManager.sharedInstance.currentViewController()
        actualController.present(alertController, animated: true, completion: nil)
        
      }
      
    }, actionsToMakeWhenFailed: {
    
      UtilityManager.sharedInstance.hideLoader()
      
      let alertController = UIAlertController(title: "ERROR",
                                              message: "Error getting new access token. We'll try to bring info from local data base.",
                                              preferredStyle: UIAlertControllerStyle.alert)
      
      let cancelAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
        
        let arrayOfSeriesCD = self.getAllSeriesFromCoreData()
        let arrayOfSeries = self.transformFromCoreDataToNaturalSerie(arrayOfSerieCD: arrayOfSeriesCD)
        
        let allSeriesVC = AllSeriesViewController.init(newArrayOfSeries: arrayOfSeries)
        self.navigationController?.pushViewController(allSeriesVC, animated: true)
        
      }
      alertController.addAction(cancelAction)
      
      let actualController = UtilityManager.sharedInstance.currentViewController()
      actualController.present(alertController, animated: true, completion: nil)
    
    })
    
  }
  
  private func insert(arrayOfSeries: Array<Serie>) {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    for serie in arrayOfSeries {
      
      let newSerie = NSEntityDescription.insertNewObject(forEntityName: "SerieCD", into: context)
      newSerie.setValue(serie.serieId, forKey: "serieId")
      newSerie.setValue(serie.adult, forKey: "adult")
      newSerie.setValue(serie.averageScore, forKey: "averageScore")
      newSerie.setValue(serie.finishedAiring, forKey: "finishedAiring")
      newSerie.setValue(serie.genres, forKey: "genres")
      newSerie.setValue(serie.description, forKey: "serieDescription")
      newSerie.setValue(serie.titleJapanese, forKey: "titleJapanese")
      newSerie.setValue(serie.titleRomaji, forKey: "titleRomaji")
      newSerie.setValue(serie.totalEpisodes, forKey: "totalEpisodes")
      newSerie.setValue(serie.type, forKey: "type")
      newSerie.setValue(serie.urlBannerImage, forKey: "urlBannerImage")
      newSerie.setValue(serie.urlLargeImage, forKey: "urlLargeImage")
      newSerie.setValue(serie.urlMediumImage, forKey: "urlMediumImage")
      newSerie.setValue(serie.urlSmallImage, forKey: "urlSmallImage")
      
    }
    
    do {
      
      try context.save()
      
    } catch {
      

      
    }
    
  }
  
  private func getAllSeriesFromCoreData() -> Array<SerieCD> {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "SerieCD")
    request.returnsObjectsAsFaults = false
    
    var arrayOfSerieCD = Array<SerieCD>()
    
    do {
      
      arrayOfSerieCD = try context.fetch(request) as! Array<SerieCD>
      
    } catch {
      
      let alertController = UIAlertController(title: "ERROR",
                                              message: "Error from internal data base, close and reopen the app",
                                              preferredStyle: UIAlertControllerStyle.alert)
      
      let cancelAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
        
        
      }
      
      alertController.addAction(cancelAction)
      
      let actualController = UtilityManager.sharedInstance.currentViewController()
      actualController.present(alertController, animated: true, completion: nil)
      
    }
    
    return arrayOfSerieCD.sorted{ $0.titleRomaji! > $1.titleRomaji! }
    
  }
  
  private func transformFromCoreDataToNaturalSerie(arrayOfSerieCD: Array<SerieCD>) -> Array<Serie> {
    
    var arrayOfNaturalSeries: Array<Serie> = Array<Serie>()

    for serieCD in arrayOfSerieCD {
      
      let newId = serieCD.serieId!
      let newTitleRomaji = serieCD.titleRomaji!
      let newTitleJapanese = serieCD.titleJapanese!
      let newType = serieCD.type!
      let newAdult = serieCD.adult
      let newAverageScore = serieCD.averageScore!
      let newUrlSmallImage = serieCD.urlSmallImage!
      let newUrlMediumImage = serieCD.urlMediumImage!
      let newUrlLargeImage = serieCD.urlLargeImage!
      let newUrlBannerImage = serieCD.urlBannerImage!
      let newTotalEpisodes = serieCD.totalEpisodes!
      let newGenres = serieCD.genres! as! [String]
      let newFinishedAiring = serieCD.finishedAiring!
      let newDescription = serieCD.serieDescription!
      
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
      
      arrayOfNaturalSeries.append(newSerie)
      
    }
    
    return arrayOfNaturalSeries
    
  }
  
  private func getNonExistentelements(arrayFromServer: Array<Serie>, arrayFromCoreData: Array<SerieCD>) -> Array<Serie> {
    
    if arrayFromCoreData.count > 0 {
      
      var arrayOfNonExistingInCoreData = Array<Serie>()
      
      for serverSerie in arrayFromServer {
        
        for i in 0...arrayFromCoreData.count - 1 {
          
          if arrayFromCoreData[i].serieId! == serverSerie.serieId {
            
            break
            
          } else {
            
            if i == arrayFromCoreData.count - 1 {
              
              arrayOfNonExistingInCoreData.append(serverSerie)
              
              break
              
            }
            
          }
          
        }
        
      }
      
      return arrayOfNonExistingInCoreData
      
    } else {
      
      return arrayFromServer
      
    }
    
  }
  
}
