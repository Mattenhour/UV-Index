//
//  UVIndexNowViewModel.swift
//  UV Index
//
//  Created by Matt Ridenhour on 8/21/20.
//  Copyright © 2020 Matt Ridenhour. All rights reserved.
//

import Foundation
import CoreData
import SwiftUI

/// Holds UVHour data for a given area (based on user zipcode) of the current UV index
class UVIndexNowViewModel: NSObject, ObservableObject
{
    private var isFirstAppearance = true
    private let moc = PersistentStore.shared.context
    private let nowController: NSFetchedResultsController<UVHour>
    
    @Published var data: UVIndexNowModel = UVIndexNowModel()
    @Published var coreDateError: Bool = false
    
    override init()
    {
        nowController = NSFetchedResultsController(fetchRequest: UVHour.uvIndexNowRequest,
                                                   managedObjectContext: moc,
                                                   sectionNameKeyPath: nil, cacheName: nil)
        
        super.init()
        
        nowController.delegate = self
        
        do {
            try nowController.performFetch()
            let results = nowController.fetchedObjects ?? []
            
            setUVIndex(from: results)
            
        } catch {
            print("failed to fetch items!")
        }
    }
    
    func setUVIndex(from hours: [UVHour])
    {
        let date = Date()
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.dateFormat = "MMM/d/yyyy hh a"

        let todaystr = formatter.string(from: date)
        
        print("UVIndexNowVM.setUVIndex() size of UVHour array: \(hours.count)")
        
        for i in hours
        {
            let tempDateStr = formatter.string(from: i.wrappedDateTime)

            if todaystr == tempDateStr
            {
                print("UV Now VM Date matches! \(tempDateStr)")
                
//                let tempUVNowModel: UVIndexNowModel = UVIndexNowModel(uvIndex: i.wrappedUVIndex, dateTime: i.wrappedDateTime)
                
                self.data.uvIndex = i.wrappedUVIndex
                self.data.dateTime = i.wrappedDateTime
                break
            }
        }
    }
    
}

extension UVIndexNowViewModel: NSFetchedResultsControllerDelegate
{
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>)
    {
        print("UVIndexNowViewModel controllerDidChangeContent was called. New Stuff in DB")
        guard let results = controller.fetchedObjects as? [UVHour] else { return }
        
//        guard let uvHours = results.first else { return }
        
        setUVIndex(from: results)
    }
}
