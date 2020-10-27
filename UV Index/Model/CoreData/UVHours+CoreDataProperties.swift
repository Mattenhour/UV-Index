//
//  UVHours+CoreDataProperties.swift
//  UV Index
//
//  Created by Matt Ridenhour on 8/13/20.
//  Copyright © 2020 Matt Ridenhour. All rights reserved.
//
//

import Foundation
import CoreData


extension UVHours {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UVHours> {
        return NSFetchRequest<UVHours>(entityName: "UVHours")
    }

    @NSManaged public var year: Int16
    @NSManaged public var month: Int16
    @NSManaged public var day: Int16
    @NSManaged public var hours: NSSet?
    
    var wrappedYear: Int { Int(year) }
    var wrappedMonth: Int { Int(month) }
    var wrappedDay: Int { Int(day) }
    
    var wrappedHours: [UVHour] {
        let set = hours as? Set<UVHour> ?? []
        return set.sorted(by: { $0.wrappedOrder < $1.wrappedOrder })
    }
}

// MARK: Generated accessors for hours
extension UVHours {

    @objc(addHoursObject:)
    @NSManaged public func addToHours(_ value: UVHour)

    @objc(removeHoursObject:)
    @NSManaged public func removeFromHours(_ value: UVHour)

    @objc(addHours:)
    @NSManaged public func addToHours(_ values: NSSet)

    @objc(removeHours:)
    @NSManaged public func removeFromHours(_ values: NSSet)

}
