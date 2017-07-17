//
//  Serie.swift
//  ApplaudoStudioTextAniList
//
//  Created by Israel Gutierrez on 09/07/17.
//  Copyright © 2017 Israel Gutierrez. All rights reserved.
//

import Foundation

class Serie {
  
  var serieId: String! = nil
  var titleRomaji: String! = nil
  var titleJapanese: String! = nil
  var averageScore: String! = nil
  var totalEpisodes: String! = nil
  var urlSmallImage: String! = nil
  var urlMediumImage: String! = nil
  var urlLargeImage: String! = nil
  var urlBannerImage: String! = nil
  var type: String! = nil
  var finishedAiring: String! = nil
  var genres: [String] = [String]()
  var adult: Bool! = nil
  var description: String! = nil
  
  init(newSerieId: String, newTitleRomaji: String, newTitleJapanese: String, newAverageScore: String, newTotalEpisodes: String, newUrlSmallImage: String, newUrlMediumImage: String, newUrlLargeImage: String, newUrlBannerImage: String, newType: String, newFinishedAiring: String, newGenres: [String], newAdult: Bool, newDescription: String) {
    
    serieId = newSerieId
    titleRomaji = newTitleRomaji
    titleJapanese = newTitleJapanese
    averageScore = newAverageScore
    totalEpisodes = newTotalEpisodes
    urlSmallImage = newUrlSmallImage
    urlMediumImage = newUrlMediumImage
    urlLargeImage = newUrlLargeImage
    urlBannerImage = newUrlBannerImage
    type = newType
    finishedAiring = newFinishedAiring
    genres = newGenres
    adult = newAdult
    description = newDescription
    
  }
  
}
