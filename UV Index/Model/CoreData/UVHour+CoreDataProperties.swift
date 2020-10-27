//
//  UVHour+CoreDataProperties.swift
//  UV Index
//
//  Created by Matt Ridenhour on 8/13/20.
//  Copyright © 2020 Matt Ridenhour. All rights reserved.
//
//

import Foundation
import CoreData

extension UVHour {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UVHour> {
        return NSFetchRequest<UVHour>(entityName: "UVHour")
    }

    @NSManaged public var date_time: Date?
    @NSManaged public var order: Int16
    @NSManaged public var uv_index: Int16
    @NSManaged public var origin: UVHours?
    
    var wrappedDateTime: Date { date_time ?? Date() }
    var wrappedOrder: Int { Int(order) }
    var wrappedUVIndex: Int { Int(uv_index) }
}
