//
//  SetUpAPICall.swift
//  UV Index
//
//  Created by Matt Ridenhour on 8/23/20.
//  Copyright © 2020 Matt Ridenhour. All rights reserved.
//

import Foundation

class APIEndPoints {
    
    private let baseURL = URL(string: "https://enviro.epa.gov/enviro/efservice")
    private let returnData = "JSON"
    
    var zipCode = UserSettingsModel().zipCode
    
    //TODO: add public func fetchDailyIndex
    
    public func fetchHourlyIndex(result: @escaping(Result<[JSONHourlyIndex], APIServiceError>) -> Void)
    {
        let apiEndpoint = baseURL!
            .appendingPathComponent("getEnvirofactsUVHOURLY")
            .appendingPathComponent("ZIP")
            .appendingPathComponent(zipCode)
            .appendingPathComponent(returnData)
        
        fetchResources(url: apiEndpoint, completion: result)
    }
    
}
