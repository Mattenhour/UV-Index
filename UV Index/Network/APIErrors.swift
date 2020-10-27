//
//  APIErrors.swift
//  UV Index
//
//  Created by Matt Ridenhour on 8/11/20.
//  Copyright © 2020 Matt Ridenhour. All rights reserved.
//

import Foundation
public enum APIServiceError: Error
{
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case decodeError
}
