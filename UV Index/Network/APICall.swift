//
//  APICall.swift
//  UV Index
//
//  Created by Matt Ridenhour on 8/11/20.
//  Copyright © 2020 Matt Ridenhour. All rights reserved.
//

import Foundation

/// Calls API to retrieve data
/// - Parameters:
///   - url: API URL address
///   - completion:  escaping function that will return Result of generic T on success, or APIServiceError on failure
func fetchResources<T: Decodable>(url: URL, completion: @escaping (Result<T, APIServiceError>) -> Void)
{
    guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
        completion(.failure(.invalidEndpoint))
        return
    }
    
    guard let url = urlComponents.url else {
        completion(.failure(.invalidEndpoint))
        return
    }
    
    let jsonDecoder: JSONDecoder =
    {
       let jsonDecoder = JSONDecoder()
       let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = "MMM/d/yyyy hh a"
       jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
       return jsonDecoder
    }()
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
            completion(.failure(.invalidResponse))
            return
        }
        
        guard let data = data else {
            completion(.failure(.noData))
            return
        }
        
        do {
         let values = try jsonDecoder.decode(T.self, from: data)
         completion(.success(values))
        } catch {
         completion(.failure(.decodeError))
        }
    }.resume()
}
