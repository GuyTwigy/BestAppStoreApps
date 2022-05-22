//
//  Family+CoreDataProperties.swift
//  BestAppStoreApps
//
//  Created by Guy Twig on 16/05/2022.
//
//

import Foundation
import CoreData


extension Family {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Family> {
        return NSFetchRequest<Family>(entityName: "Family")
    }

    @NSManaged public var familyName: String?
    @NSManaged public var person: NSSet?

}

// MARK: Generated accessors for person
extension Family {

    @objc(addPersonObject:)
    @NSManaged public func addToPerson(_ value: Person)

    @objc(removePersonObject:)
    @NSManaged public func removeFromPerson(_ value: Person)

    @objc(addPerson:)
    @NSManaged public func addToPerson(_ values: NSSet)

    @objc(removePerson:)
    @NSManaged public func removeFromPerson(_ values: NSSet)

}

extension Family : Identifiable {

}
