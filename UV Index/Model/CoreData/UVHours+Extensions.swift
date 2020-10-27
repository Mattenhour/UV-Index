//
//  UVHours+Extensions.swift
//  UV Index
//
//  Created by Matt Ridenhour on 8/15/20.
//  Copyright © 2020 Matt Ridenhour. All rights reserved.
//
// https://github.com/delawaremathguy/ShoppingList

import Foundation
import CoreData
import SwiftUI

extension UVHours {
    
    /// Finds date from a date format string
    /// - Parameter formatStr: date format string used
    /// - Returns: date from formatStr in interger form
    static private func getdate(from formatStr: String) -> Int
    {
        let today = Date()
        let dateformater =  DateFormatter()
        dateformater.dateFormat = formatStr
        let dateStr = dateformater.string(from: today)
        return Int(dateStr)!
    }
    
    /// Finds if UVHours data with todays date is stored in core data
    /// - Returns: Boolean value if data exists in core data
    static func isDataStored() -> Result<Bool,CoreDataErrors>
    {
        var isUVIndexDataStored: Bool = false
        var uvHoursSize: Int = 0
        
        let moc = PersistentStore.shared.context
        let request: NSFetchRequest = UVHours.fetchRequest()
        
        let year =  getdate(from: "yyyy")
        let month = getdate(from: "M")
        let day = getdate(from: "d")
        
        let predYear = NSPredicate(format: "year == %i", year)
        let predMonth = NSPredicate(format: "month == %i", month)
        let predDay = NSPredicate(format: "day == %i", day)
        
        // find where UVHours.date is today's year,month,date (yyyy,M,d)
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predYear,predMonth,predDay])
        
        do {
            uvHoursSize = try moc.count(for: request)
        } catch {
            print("isDataStored() failed: Error \(error.localizedDescription)")
        }
        
        if uvHoursSize > 0 {
            isUVIndexDataStored = true
            return .success(isUVIndexDataStored)
        }
        return .failure(.notFound)
    }
    
    /// Removes all UVHours data.
    /// At the moment I only need to store UVHours data for todays date.
    static func deleteAll()
    {
//        let request: NSFetchRequest<NSFetchRequestResult> = UVHours.fetchRequest()
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
//
//        let moc = PersistentStore.shared.context
//
//        do {
//            try moc.execute(deleteRequest)
//            print("New day. Deleting all old data")
//        } catch {
//            print("Delete failed: Error \(error.localizedDescription)")
//        }
        
        let moc = PersistentStore.shared.context
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UVHours")
        
        // Configure Fetch Request
        fetchRequest.includesPropertyValues = false
        
        do {
            let hours = try moc.fetch(fetchRequest) as! [NSManagedObject]
            
            print("UVHours+Extension deleteAll() size: \(hours.count)")
            
            for hour in hours {
                moc.delete(hour)
            }
            
            // Save Changes
            try moc.save()
        }
        catch {
            print("Delete failed: Error \(error.localizedDescription)")
        }
    }
    
    /// Saves JSONHourlyIndex to core data
    /// - Parameter apiResults: uvHourly data from EPA API
    static func saveHourlyIndex(from apiResults: [JSONHourlyIndex])
    {
        let moc = PersistentStore.shared.context
        let uvHourly = UVHours(context: moc)
        
        uvHourly.year = Int16(getdate(from: "yyyy"))
        uvHourly.month = Int16(getdate(from: "M"))
        uvHourly.day = Int16(getdate(from: "d"))
        
        print("size of api results that will be saved \(apiResults.count)")
        
        for i in apiResults
        {
            let uvHour = UVHour(context: moc)
            uvHour.date_time = i.date
            uvHour.order = Int16(i.id)
            uvHour.uv_index = Int16(i.uvIndex)
            
            uvHourly.addToHours(uvHour)
        }
        
        try? moc.save()
        
    }
    
    /// Returns NSFetchRequest for UVHours entities with today's date
    static var todayHourlyIndexRequest: NSFetchRequest<UVHours>
    {
        let request: NSFetchRequest = UVHours.fetchRequest()
        
        let year =  getdate(from: "yyyy")
        let month = getdate(from: "M")
        let day = getdate(from: "d")
        
        let predYear = NSPredicate(format: "year == %i", year)
        let predMonth = NSPredicate(format: "month == %i", month)
        let predDay = NSPredicate(format: "day == %i", day)
        
        // find where UVHours.date is today's year,month,date (yyyy,M,d)
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predYear,predMonth,predDay])
        request.sortDescriptors = [NSSortDescriptor(key: "month", ascending: true)]
        
        return request
    }
    
    /// Finds UVHours entity with today's date
    /// - Returns: Result with success of UVHours, or Error of CoreDataErrors
    static func getTodayHourlyIndex() -> Result<UVHours,CoreDataErrors>
    {
        let moc = PersistentStore.shared.context
        let request: NSFetchRequest = UVHours.fetchRequest()
        
        let year =  getdate(from: "yyyy")
        let month = getdate(from: "M")
        let day = getdate(from: "d")
        
        let predYear = NSPredicate(format: "year == %i", year)
        let predMonth = NSPredicate(format: "month == %i", month)
        let predDay = NSPredicate(format: "day == %i", day)
        
        // find where UVHours.date is today's year,month,date (yyyy,M,d)
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predYear,predMonth,predDay])
        
        do {
            let values = try moc.fetch(request)
            
            if let firstUVHours = values.first {
                return .success(firstUVHours)
            }
        } catch {
             print("getTodayHourlyIndex() failed: Error \(error.localizedDescription)")
        }
        
        return .failure(.notFound)
    }
}
