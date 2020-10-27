//
//  UVChartModel.swift
//  UV Index
//
//  Created by Matt Ridenhour on 8/13/20.
//  Copyright © 2020 Matt Ridenhour. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData

class UVChartViewModel: NSObject, ObservableObject {
    private var isFirstAppearance = true
    private let chartController: NSFetchedResultsController<UVHours>
    
    @Published var data: [UVHour] = []
//        {
//        didSet {
//            print("\(data.count) new UVChartViewModel.data's have been added")
//        }
//    }
    
    @Published var coreDateError: Bool = false
    
    override init() {
        let moc = PersistentStore.shared.context
        chartController = NSFetchedResultsController(fetchRequest: UVHours.todayHourlyIndexRequest,
                                                     managedObjectContext: moc,
                                                     sectionNameKeyPath: nil, cacheName: nil)
        
        super.init()
        
        chartController.delegate = self
        
        do {
            try chartController.performFetch()
            let results = chartController.fetchedObjects ?? []
            
            guard let uvHours = results.first else {
                coreDateError = true
                return
            }
            
            setFilteredData(from: uvHours.wrappedHours)
            
        } catch {
            print("failed to fetch items!")
        }
    }
    
//    public func setUpData()
//    {
//        print("UVChartView has appeared")
//        if isFirstAppearance
//        {
//            fetchFromCoreData()
//        }
//    }
    
    private func fetchFromCoreData()
    {
        let result = UVHours.getTodayHourlyIndex()
        switch result
        {
            case .success(let uvHours):
                setFilteredData(from: uvHours.wrappedHours)
                isFirstAppearance = false
            case .failure(let error):
                coreDateError = true
                print("Error in UVChartViewModel's fetchFromCoreData()")
                print(error.localizedDescription)
        }
    }
    
    /// Keeps only values where uv index is greater than or equal to 1
    private func setFilteredData(from data: [UVHour])
    {
        self.data = data.filter({$0.uv_index >= 1})
    }
}

extension UVChartViewModel: NSFetchedResultsControllerDelegate
{
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>)
    {
        guard let results = controller.fetchedObjects as? [UVHours] else { return }
        guard let uvHours = results.first else { return }
        
        setFilteredData(from: uvHours.wrappedHours)
    }
}
