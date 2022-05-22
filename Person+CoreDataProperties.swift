//
//  Person+CoreDataProperties.swift
//  BestAppStoreApps
//
//  Created by Guy Twig on 16/05/2022.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var yearOld: Int64
    @NSManaged public var family: Family?

}

extension Person : Identifiable {

}
