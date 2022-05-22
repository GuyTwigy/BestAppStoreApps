//
//  ResponsePaidAppsCoreData+CoreDataProperties.swift
//  BestAppStoreApps
//
//  Created by Guy Twig on 15/05/2022.
//
//

import Foundation
import CoreData


extension ResponsePaidAppsCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ResponsePaidAppsCoreData> {
        return NSFetchRequest<ResponsePaidAppsCoreData>(entityName: "ResponsePaidAppsCoreData")
    }

    @NSManaged public var feedCoreData: FeedCoreData?

}

extension ResponsePaidAppsCoreData : Identifiable {

}
