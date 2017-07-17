//
//  SerieCD+CoreDataProperties.swift
//  
//
//  Created by Israel Gutierrez on 17/07/17.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension SerieCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SerieCD> {
        return NSFetchRequest<SerieCD>(entityName: "SerieCD");
    }

    @NSManaged public var serieId: String?
    @NSManaged public var titleRomaji: String?
    @NSManaged public var titleJapanese: String?
    @NSManaged public var averageScore: String?
    @NSManaged public var totalEpisodes: String?
    @NSManaged public var urlSmallImage: String?
    @NSManaged public var urlMediumImage: String?
    @NSManaged public var urlLargeImage: String?
    @NSManaged public var urlBannerImage: String?
    @NSManaged public var type: String?
    @NSManaged public var finishedAiring: String?
    @NSManaged public var genres: NSObject?
    @NSManaged public var adult: Bool
    @NSManaged public var serieDescription: String?

}
