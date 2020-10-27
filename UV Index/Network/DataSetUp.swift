//
//  SetUpAPICall.swift
//  UV Index
//
//  Created by Matt Ridenhour on 8/23/20.
//  Copyright © 2020 Matt Ridenhour. All rights reserved.
//

import Foundation

class APIEndPoints {
//    private var apiResults = [JSONHourlyIndex]() {
//        didSet {
//            print("I just changed from \(oldValue.count) to \(apiResults.count)")
//        }
//    }
    
    private let baseURL = URL(string: "https://enviro.epa.gov/enviro/efservice")
    private let returnData = "JSON"
    
    var zipCode = UserSettingsModel().zipCode
    
    public func start()
    {
        UVHours.deleteAll()
        
        makeAPICall {
            print("API call is done")
        }
        
    }
    
//    /// Finds if UVHours data with todays date is stored in core data
//    /// - Returns: Boolean value if data exists in core data
//    private func inCoreData() -> Bool
//    {
//        let result = UVHours.isDataStored()
//
//        switch result
//        {
//            case .success(let isDataStored):
//                return isDataStored
//            case .failure(_):
//                self.errorCoreData = true
//                print("DataSetUp inCoreData() no data was found for today")
//                return false
//        }
//    }
    
    /// Retrieve's UV data from EPA API, and saves results to core data
    /// - Parameter onCompleted: needed so fucntion  complete
    private func makeAPICall(onCompleted: @escaping( () -> Void) )
    {
//        fetchHourlyIndex(with: zipCode) { (result: Result<[JSONHourlyIndex], APIServiceError>) in
//            switch result {
//                case .success(let data):
//                    if data.count > 0 {
//                        UVHours.saveHourlyIndex(from: data)
//                        onCompleted()
//                    } else {
//                        print("no data found")
//                        onCompleted()
//                    }
//                case .failure(let error):
//                    self.errorAPI = true
//                    print("Error DataSetup.makeAPICall(): \(error.localizedDescription)")
//                    onCompleted()
//            }
//        }
    }
    
    public func fetchHourlyIndex(with zipCode: String, result: @escaping(Result<[JSONHourlyIndex], APIServiceError>) -> Void)
    {
        let apiEndpoint = baseURL!
            .appendingPathComponent("getEnvirofactsUVHOURLY")
            .appendingPathComponent("ZIP")
            .appendingPathComponent(zipCode)
            .appendingPathComponent(returnData)
        
        fetchResources(url: apiEndpoint, completion: result)
    }
    
}
