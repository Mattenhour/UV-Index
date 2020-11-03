//
//  UVViewModel.swift
//  UV Index
//
//  Created by Matt Ridenhour on 8/11/20.
//  Copyright © 2020 Matt Ridenhour. All rights reserved.
//

import SwiftUI
import CoreData

class HomeTabViewModel: ObservableObject
{
    private var apiResults = [JSONHourlyIndex]() {
        didSet {
            print("I just changed from \(oldValue.count) to \(apiResults.count)")
        }
    }
    
    @Published var errorCoreData = false
    @Published var apiError = false
    
    func setUpData()
    {
        //TODO: add switch statement here that will go through StateMachine State enum
        //TODO: test by printing 
        let isDataStored = inCoreData()
        
        if !isDataStored
        {
            print("No data stored for today")
            UVHours.deleteAll()
            
            callUVHourlyAPI {
                self.saveAPIData()
            }
        }
    }
    
    /// Finds if UVHours data with todays date is stored in core data
    /// - Returns: Boolean value if data exists in core data
    private func inCoreData() -> Bool
    {
        let result = UVHours.isDataStored()
        
        switch result
        {
            case .success(let isDataStored):
                return isDataStored
            case .failure(_):
                self.errorCoreData = true
                print("DataSetUp inCoreData() no data was found for today")
                return false
        }
    }
    
    /// Retrieve's UV data from EPA API, and saves results to core data
    /// - Parameter onCompleted: completion handler for when function finishes
    private func callUVHourlyAPI(onCompleted: @escaping( () -> Void) )
    {
        APIEndPoints().fetchHourlyIndex { (result: Result<[JSONHourlyIndex], APIServiceError>) in
            switch result
            {
                case .success(let data):
                    DispatchQueue.main.async {
                        self.apiResults = data
                        onCompleted()
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.apiError = true
                        print("Error DataSetup.makeAPICall(): \(error.localizedDescription)")
                        onCompleted()
                    }
            }
        }
    }
    
    private func saveAPIData()
    {
        if apiResults.count > 0
        {
            UVHours.saveHourlyIndex(from: apiResults)
        }
    }
}
