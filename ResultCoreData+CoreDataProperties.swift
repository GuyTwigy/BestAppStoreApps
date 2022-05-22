//
//  ResultCoreData+CoreDataProperties.swift
//  BestAppStoreApps
//
//  Created by Guy Twig on 15/05/2022.
//
//

import Foundation
import CoreData


extension ResultCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ResultCoreData> {
        return NSFetchRequest<ResultCoreData>(entityName: "ResultCoreData")
    }

    @NSManaged public var name: String?
    @NSManaged public var artworkUrl100: String?
    @NSManaged public var url: String?
    
    
    func setInfo(result:Results) {
        self.name = result.name
        self.artworkUrl100 = 
    }
}

extension ResultCoreData : Identifiable {

}
