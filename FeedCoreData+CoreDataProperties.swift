//
//  FeedCoreData+CoreDataProperties.swift
//  BestAppStoreApps
//
//  Created by Guy Twig on 15/05/2022.
//
//

import Foundation
import CoreData


extension FeedCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FeedCoreData> {
        return NSFetchRequest<FeedCoreData>(entityName: "FeedCoreData")
    }

    @NSManaged public var resultCoreData: NSSet?

}

// MARK: Generated accessors for resultCoreData
extension FeedCoreData {

    @objc(addResultCoreDataObject:)
    @NSManaged public func addToResultCoreData(_ value: ResultCoreData)

    @objc(removeResultCoreDataObject:)
    @NSManaged public func removeFromResultCoreData(_ value: ResultCoreData)

    @objc(addResultCoreData:)
    @NSManaged public func addToResultCoreData(_ values: NSSet)

    @objc(removeResultCoreData:)
    @NSManaged public func removeFromResultCoreData(_ values: NSSet)

}

extension FeedCoreData : Identifiable {

}
