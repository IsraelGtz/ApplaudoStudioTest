//
//  AllSeriesViewController.swift
//  ApplaudoStudioTextAniList
//
//  Created by Israel Gutierrez on 09/07/17.
//  Copyright © 2017 Israel Gutierrez. All rights reserved.
//

import UIKit

class AllSeriesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
  private var mainScrollView: UIScrollView! = nil
  private var tvCollectionView: UICollectionView! = nil
  private var tvShortCollectionView: UICollectionView! = nil
  private var movieCollectionView: UICollectionView! = nil
  private var specialCollectionView: UICollectionView! = nil
  private var ovaCollectionView: UICollectionView! = nil
  private var otherCollectionView: UICollectionView! = nil
  
  private var allSeries: Array<Serie> = Array<Serie>()
  private var arrayOfTVSeries: Array<Serie> = Array<Serie>()
  private var arrayOfTVShortSeries: Array<Serie> = Array<Serie>()
  private var arrayOfMovieSeries: Array<Serie> = Array<Serie>()
  private var arrayOfSpecialSeries: Array<Serie> = Array<Serie>()
  private var arrayOfOVASeries: Array<Serie> = Array<Serie>()
  private var arrayOfOtherSeries: Array<Serie> = Array<Serie>()
  
  private let cellTVID = "cellTV"
  private let cellTVShortID = "cellTVShort"
  private let cellMovieID = "cellMovie"
  private let cellSpecialID = "cellSpecial"
  private let cellOVAID = "cellOVA"
  private let cellOtherID = "cellOther"
  
  
  init(newArrayOfSeries: Array<Serie>) {
    
    allSeries = newArrayOfSeries
    
    super.init(nibName: nil, bundle: nil)

  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    
    self.view = UIView.init(frame: UIScreen.main.bounds)
    self.view.backgroundColor = UIColor.white
    self.navigationController?.navigationBar.isHidden = true
    
    self.orderAllTheByTypeAllTheSeries()
    self.initInterface()
    
  }
  
  private func orderAllTheByTypeAllTheSeries() {
    
    for serie in allSeries {
      
      switch serie.type {
      case "TV":
        arrayOfTVSeries.append(serie)
        break
        
      case "TV Short":
        arrayOfTVShortSeries.append(serie)
        break
        
      case "Movie":
        arrayOfMovieSeries.append(serie)
        break
        
      case "Special":
        arrayOfSpecialSeries.append(serie)
        break
        
      case "OVA":
        arrayOfOVASeries.append(serie)
        break
        
      default:
        arrayOfOtherSeries.append(serie)
        break
        
      }
      
    }
    
  }
  
  private func initInterface() {
    
    self.initMainScrollView()
    self.initTVCollectionView()
    self.initTVShortCollectionView()
    self.initMovieCollectionView()
    self.initSpecialCollectionView()
    self.initOVACollectionView()
    self.initOtherCollectionView()
    
  }
  
  private func initMainScrollView() {
    
    if mainScrollView != nil {
      
      mainScrollView.removeFromSuperview()
      mainScrollView = nil
      
    }
    
    mainScrollView = UIScrollView.init(frame: self.view.frame)
    
    let newContentSize = CGSize.init(width: mainScrollView.frame.size.width,
                                    height: mainScrollView.frame.size.height + (450.0 * UtilityManager.sharedInstance.conversionHeight))
    
    mainScrollView.contentSize = newContentSize
    self.view.addSubview(mainScrollView)
    
  }
  
  private func initTVCollectionView() {
    
    if tvCollectionView != nil {
      
      tvCollectionView.removeFromSuperview()
      tvCollectionView = nil
      
    }
    
    let frameForCollection = CGRect.init(x: 15.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: 30.0 * UtilityManager.sharedInstance.conversionHeight,
                                     width: self.view.frame.size.width - (30.0 * UtilityManager.sharedInstance.conversionWidth),
                                    height: 115.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let layout = UICollectionViewFlowLayout.init()
    layout.scrollDirection = .horizontal
    tvCollectionView = UICollectionView.init(frame: frameForCollection, collectionViewLayout: layout)
    tvCollectionView.register(SerieViewCell.self, forCellWithReuseIdentifier: cellTVID)
    tvCollectionView.backgroundColor = UIColor.init(red: 173.0/255.0, green: 242.0/255.0, blue: 147.0/255.0, alpha: 0.2)
    tvCollectionView.delegate = self
    tvCollectionView.dataSource = self
    
    self.mainScrollView.addSubview(tvCollectionView)
    
  }
  
  private func initTVShortCollectionView() {
    
    if tvShortCollectionView != nil {
      
      tvShortCollectionView.removeFromSuperview()
      tvShortCollectionView = nil
      
    }
    
    let frameForCollection = CGRect.init(x: 15.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: tvCollectionView.frame.origin.y + tvCollectionView.frame.size.height + (30.0 * UtilityManager.sharedInstance.conversionHeight),
                                         width: self.view.frame.size.width - (30.0 * UtilityManager.sharedInstance.conversionWidth),
                                         height: 115.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let layout = UICollectionViewFlowLayout.init()
    layout.scrollDirection = .horizontal
    tvShortCollectionView = UICollectionView.init(frame: frameForCollection, collectionViewLayout: layout)
    tvShortCollectionView.register(SerieViewCell.self, forCellWithReuseIdentifier: cellTVShortID)
    tvShortCollectionView.backgroundColor = UIColor.init(red: 151.0/255.0, green: 157.0/255.0, blue: 228.0/255.0, alpha: 0.2)
    tvShortCollectionView.delegate = self
    tvShortCollectionView.dataSource = self
    
    self.mainScrollView.addSubview(tvShortCollectionView)
    
  }
  
  private func initMovieCollectionView() {
    
    if movieCollectionView != nil {
      
      movieCollectionView.removeFromSuperview()
      movieCollectionView = nil
      
    }
    
    let frameForCollection = CGRect.init(x: 15.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: tvShortCollectionView.frame.origin.y + tvShortCollectionView.frame.size.height + (30.0 * UtilityManager.sharedInstance.conversionHeight),
                                         width: self.view.frame.size.width - (30.0 * UtilityManager.sharedInstance.conversionWidth),
                                         height: 115.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let layout = UICollectionViewFlowLayout.init()
    layout.scrollDirection = .horizontal
    movieCollectionView = UICollectionView.init(frame: frameForCollection, collectionViewLayout: layout)
    movieCollectionView.register(SerieViewCell.self, forCellWithReuseIdentifier: cellMovieID)
    movieCollectionView.backgroundColor = UIColor.init(red: 255.0/255.0, green: 228.0/255.0, blue: 155.0/255.0, alpha: 0.2)
    movieCollectionView.delegate = self
    movieCollectionView.dataSource = self
    
    self.mainScrollView.addSubview(movieCollectionView)
    
  }
  
  private func initSpecialCollectionView() {
    
    if specialCollectionView != nil {
      
      specialCollectionView.removeFromSuperview()
      specialCollectionView = nil
      
    }
    
    let frameForCollection = CGRect.init(x: 15.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: movieCollectionView.frame.origin.y + movieCollectionView.frame.size.height + (30.0 * UtilityManager.sharedInstance.conversionHeight),
                                         width: self.view.frame.size.width - (30.0 * UtilityManager.sharedInstance.conversionWidth),
                                         height: 115.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let layout = UICollectionViewFlowLayout.init()
    layout.scrollDirection = .horizontal
    specialCollectionView = UICollectionView.init(frame: frameForCollection, collectionViewLayout: layout)
    specialCollectionView.register(SerieViewCell.self, forCellWithReuseIdentifier: cellSpecialID)
    specialCollectionView.backgroundColor = UIColor.init(red: 250.0/255.0, green: 152.0/255.0, blue: 167.0/255.0, alpha: 0.2)
    specialCollectionView.delegate = self
    specialCollectionView.dataSource = self
    
    self.mainScrollView.addSubview(specialCollectionView)
    
  }
  
  private func initOVACollectionView() {
    
    if ovaCollectionView != nil {
      
      ovaCollectionView.removeFromSuperview()
      ovaCollectionView = nil
      
    }
    
    let frameForCollection = CGRect.init(x: 15.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: specialCollectionView.frame.origin.y + specialCollectionView.frame.size.height + (30.0 * UtilityManager.sharedInstance.conversionHeight),
                                         width: self.view.frame.size.width - (30.0 * UtilityManager.sharedInstance.conversionWidth),
                                         height: 115.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let layout = UICollectionViewFlowLayout.init()
    layout.scrollDirection = .horizontal
    ovaCollectionView = UICollectionView.init(frame: frameForCollection, collectionViewLayout: layout)
    ovaCollectionView.register(SerieViewCell.self, forCellWithReuseIdentifier: cellOVAID)
    ovaCollectionView.backgroundColor = UIColor.init(red: 255.0/255.0, green: 253.0/255.0, blue: 155.0/255.0, alpha: 0.2)
    ovaCollectionView.delegate = self
    ovaCollectionView.dataSource = self
    
    self.mainScrollView.addSubview(ovaCollectionView)
    
  }
  
  private func initOtherCollectionView() {
    
    if otherCollectionView != nil {
      
      otherCollectionView.removeFromSuperview()
      otherCollectionView = nil
      
    }
    
    let frameForCollection = CGRect.init(x: 15.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: ovaCollectionView.frame.origin.y + ovaCollectionView.frame.size.height + (30.0 * UtilityManager.sharedInstance.conversionHeight),
                                         width: self.view.frame.size.width - (30.0 * UtilityManager.sharedInstance.conversionWidth),
                                         height: 115.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let layout = UICollectionViewFlowLayout.init()
    layout.scrollDirection = .horizontal
    otherCollectionView = UICollectionView.init(frame: frameForCollection, collectionViewLayout: layout)
    otherCollectionView.register(SerieViewCell.self, forCellWithReuseIdentifier: cellOtherID)
    otherCollectionView.backgroundColor = UIColor.init(red: 192.0/255.0, green: 143.0/255.0, blue: 226.0/255.0, alpha: 0.2)
    otherCollectionView.delegate = self
    otherCollectionView.dataSource = self
    if arrayOfOtherSeries.count == 0 {
      
      otherCollectionView.alpha = 0.0
      
    }
    
    self.mainScrollView.addSubview(otherCollectionView)
    
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    if collectionView == tvCollectionView {
      
      return arrayOfTVSeries.count
      
    } else
    if collectionView == tvShortCollectionView {
        
      return arrayOfTVShortSeries.count
        
    } else
    if collectionView == movieCollectionView {
          
      return arrayOfMovieSeries.count
          
    } else
    if collectionView == specialCollectionView {
        
      return arrayOfSpecialSeries.count
        
    } else
    if collectionView == ovaCollectionView {
        
      return arrayOfOVASeries.count
        
    } else
    if collectionView == otherCollectionView {
      
      return arrayOfOtherSeries.count
      
    }
    
    return 0
    
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize.init(width: 125.0 * UtilityManager.sharedInstance.conversionWidth,
                      height: collectionView.frame.size.height)
    
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    var cell: SerieViewCell = SerieViewCell.init()

    if collectionView == tvCollectionView {
      
      cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellTVID, for: indexPath) as! SerieViewCell
      cell.setSerieInfo(newInfo: arrayOfTVSeries[indexPath.row])
      cell.backgroundColor = UIColor.init(red: 173.0/255.0, green: 242.0/255.0, blue: 147.0/255.0, alpha: 0.5)
      
    } else
    if collectionView == tvShortCollectionView {
        
      cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellTVShortID, for: indexPath) as! SerieViewCell
      cell.setSerieInfo(newInfo: arrayOfTVShortSeries[indexPath.row])
      cell.backgroundColor = UIColor.init(red: 151.0/255.0, green: 157.0/255.0, blue: 228.0/255.0, alpha: 0.5)
      
    } else
    if collectionView == movieCollectionView {
          
      cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellMovieID, for: indexPath) as! SerieViewCell
      cell.setSerieInfo(newInfo: arrayOfMovieSeries[indexPath.row])
      cell.backgroundColor = UIColor.init(red: 255.0/255.0, green: 228.0/255.0, blue: 155.0/255.0, alpha: 0.5)
      
    } else
    if collectionView == specialCollectionView {
            
      cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellSpecialID, for: indexPath) as! SerieViewCell
      cell.setSerieInfo(newInfo: arrayOfSpecialSeries[indexPath.row])
      cell.backgroundColor = UIColor.init(red: 250.0/255.0, green: 152.0/255.0, blue: 167.0/255.0, alpha: 0.5)
      
    } else
    if collectionView == ovaCollectionView {
              
      cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellOVAID, for: indexPath) as! SerieViewCell
      cell.setSerieInfo(newInfo: arrayOfOVASeries[indexPath.row])
      cell.backgroundColor = UIColor.init(red: 255.0/255.0, green: 253.0/255.0, blue: 155.0/255.0, alpha: 0.5)
      
    } else
    if collectionView == otherCollectionView {
                
      cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellOtherID, for: indexPath) as! SerieViewCell
      cell.setSerieInfo(newInfo: arrayOfOtherSeries[indexPath.row])
      cell.backgroundColor = UIColor.init(red: 192.0/255.0, green: 143.0/255.0, blue: 226.0/255.0, alpha: 0.5)
      
    }
    
    return cell
    
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    if collectionView == tvCollectionView {
      
      let serieInfo = arrayOfTVSeries[indexPath.row]
      let detailSerieVC = SerieDetailViewController.init(newSerieInfo: serieInfo)
      
      self.navigationController?.pushViewController(detailSerieVC, animated: true)
      
    } else
    if collectionView == tvShortCollectionView {
      
      let serieInfo = arrayOfTVShortSeries[indexPath.row]
      let detailSerieVC = SerieDetailViewController.init(newSerieInfo: serieInfo)
      
      self.navigationController?.pushViewController(detailSerieVC, animated: true)
        
    } else
    if collectionView == movieCollectionView {
      
      let serieInfo = arrayOfMovieSeries[indexPath.row]
      let detailSerieVC = SerieDetailViewController.init(newSerieInfo: serieInfo)
      
      self.navigationController?.pushViewController(detailSerieVC, animated: true)
          
    } else
    if collectionView == specialCollectionView {
      
      let serieInfo = arrayOfSpecialSeries[indexPath.row]
      let detailSerieVC = SerieDetailViewController.init(newSerieInfo: serieInfo)
      
      self.navigationController?.pushViewController(detailSerieVC, animated: true)
            
    } else
    if collectionView == ovaCollectionView {
      
      let serieInfo = arrayOfOVASeries[indexPath.row]
      let detailSerieVC = SerieDetailViewController.init(newSerieInfo: serieInfo)
      
      self.navigationController?.pushViewController(detailSerieVC, animated: true)
              
    } else
    if collectionView == otherCollectionView {
      
      let serieInfo = arrayOfOtherSeries[indexPath.row]
      let detailSerieVC = SerieDetailViewController.init(newSerieInfo: serieInfo)
      
      self.navigationController?.pushViewController(detailSerieVC, animated: true)
                
    }
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    
    super.viewWillAppear(animated)
    
    self.navigationController?.navigationBar.isHidden = true
    
  }
  
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    
    super.viewWillTransition(to: size, with: coordinator)
    
    coordinator.animate(alongsideTransition: nil) { (coordinator) in
      
      if UIDevice.current.orientation.isLandscape {
        
        print("Landscape")
        UtilityManager.sharedInstance.deviceRotated()
        self.initInterface()
        
      } else {
        
        print("Portrait")
        UtilityManager.sharedInstance.deviceRotated()
        self.initInterface()
        
      }
      
    }
    
  }
  
  
}
