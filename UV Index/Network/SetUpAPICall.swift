//
//  SetUpAPICall.swift
//  UV Index
//
//  Created by Matt Ridenhour on 8/23/20.
//  Copyright © 2020 Matt Ridenhour. All rights reserved.
//

import Foundation
import SwiftUI

class DataSetUp {
    private let baseURL = URL(string: "https://enviro.epa.gov/enviro/efservice")
    private let returnData = "JSON"
    
    private var apiError: Bool = false
    
    @Published var zipCode = UserSettingsModel().zipCode
    
    public func dataSetUp() {
        
    }
    
    /// Retrieve's UV data from EPA API, and saves results to core data
    /// - Parameter onCompleted: needed so fetchFromCoreDate() will not run until this function is completed
    private func makeAPICall(onCompleted: @escaping(() -> ()))
    {
        fetchHourlyIndex(with: zipCode) { (result: Result<[JSONHourlyIndex], APIServiceError>) in
            switch result
            {
                case .success(let data):
                    if data.count > 0
                    {
                        DispatchQueue.main.async
                        {
                            UVHours.saveHourlyIndex(from: data)
                            onCompleted()
                        }
                    } else
                    {
                        DispatchQueue.main.async
                        {
                            print("no data found")
                            onCompleted()
                        }
                    }
                case .failure(let error):
                    DispatchQueue.main.async
                    {
                        self.apiError = true
                        print(error.localizedDescription)
                        onCompleted()
                    }
            }
        }
    }
    
    private func fetchHourlyIndex(with zipCode: String, result: @escaping(Result<[JSONHourlyIndex], APIServiceError>) -> Void)
    {
        let apiEndpoint = baseURL!
            .appendingPathComponent("getEnvirofactsUVHOURLY")
            .appendingPathComponent("ZIP")
            .appendingPathComponent(zipCode)
            .appendingPathComponent(returnData)
        
        fetchResources(url: apiEndpoint, completion: result)
    }
}
