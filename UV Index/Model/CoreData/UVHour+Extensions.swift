//
//  UVHour+Extensions.swift
//  UV Index
//
//  Created by Matt Ridenhour on 8/24/20.
//  Copyright © 2020 Matt Ridenhour. All rights reserved.
//

import Foundation
import CoreData

extension UVHour {
    
    /// gets UVHour based on current date time
    /// - Returns: Result with success of UVHour, or failure of CoreDataErrors
    static func getCurrentUVHour() -> Result<UVHour,CoreDataErrors>
    {
        let moc = PersistentStore.shared.context
        let request: NSFetchRequest = UVHour.fetchRequest()
        
        var uvHour: [UVHour]?
        
        do {
            uvHour = try moc.fetch(request)
        } catch {
            print("getCurrentUVHour() failed: Error \(error.localizedDescription)")
            return .failure(.notFound)
        }
        
        // Unwrap uvHour if not nill
        guard let foundData = uvHour else {
            return .failure(.notFound)
        }
        
        let currentDateTime = findCurrentHour(from: foundData)
        
        // Unwrap currentDateTime if not nill
        guard let uvHourNow = currentDateTime else {
            print("UVHour+Extenstions findCurrentHour() failed: Error")
            return .failure(.notFound)
        }
        
        return .success(uvHourNow)
    }
    
    /// Removes all UVHour data.
    /// At the moment I only need to store UVHour data for todays date.
//    static func deleteAll()
//    {
//        let request: NSFetchRequest<NSFetchRequestResult> = UVHour.fetchRequest()
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
//        
//        let moc = PersistentStore.shared.context
//        
//        do {
//            try moc.execute(deleteRequest)
//        } catch {
//            print("Delete failed: Error \(error.localizedDescription)")
//        }
//    }
    
    static var uvIndexNowRequest: NSFetchRequest<UVHour>
    {
        let dateTimeNow = Date()

        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.dateFormat = "MMM/d/yyyy hh a"

        // Find date String from 'formatter.dateFormat'
        let dateHourStr = formatter.string(from: dateTimeNow)

        // Get date from dateHourStr
        let someDateTimeOpt = formatter.date(from: dateHourStr)
        
        let request: NSFetchRequest = UVHour.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "order", ascending: true)]
        
        if let someDate = someDateTimeOpt {
            request.predicate = NSPredicate(format: "date_time == %@", someDate as CVarArg)
        }
        
        return request
    }
    
    /// Iterates though array to find UVHour with current current date, and hour
    /// - Parameter hours: Array of UVHour from fetch request
    /// - Returns: UVHour optional
    private static func findCurrentHour(from hours: [UVHour]) -> UVHour?
    {
        var data: UVHour?
        
        let dateTimeNow = Date()
        let formatter = DateFormatter()
//        formatter.timeZone = .current
        formatter.dateFormat = "MMM/d/yyyy hh a"

        let todaystr = formatter.string(from: dateTimeNow)
        
        for i in hours
        {
            let tempDateStr = formatter.string(from: i.wrappedDateTime)

            if todaystr == tempDateStr
            {
                print("Date matches! \(tempDateStr)")
                data = i
                return data
            }
        }
        return data
    }
    
}
