//
//  HourlyIndex.swift
//  UV Index
//
//  Created by Matt Ridenhour on 7/18/20.
//  Copyright © 2020 Matt Ridenhour. All rights reserved.
//

import Foundation

public struct JSONHourlyIndex: Codable, Identifiable
{
    public let id: Int
    let zip: Int
    let date: Date // Look at Project8 Bundle-Decodable.swift
    let uvIndex: Int
    
    enum CodingKeys: String, CodingKey
    {
        case id = "ORDER"
        case zip = "ZIP"
        case date = "DATE_TIME"
        case uvIndex = "UV_VALUE"
    }
    // https://nsdateformatter.com/
}
