//
//  WeatherAPI.swift
//  Calendar Lite
//
//  Created by Neha Dalal on 9/13/18.
//  Copyright © 2018 Neha Dalal. All rights reserved.
//

import Foundation

final class WeatherAPI {
    
    let service: Service
    
    static let weatherServiceURL: String = "https://api.darksky.net"
    static let weatherServiceKey: String = "3cea8c3cecae045f06eac1541e988f0e"
    static let currentWeatherURL:String = "\(weatherServiceURL)/forecast/\(weatherServiceKey)/"
    
    
    init(service: Service = NetworkService()) {
        self.service = service
    }
    
    
    func currentWeatherAsync(geoCode:String, requestString: String = currentWeatherURL, _ completion: @escaping (Result<String>) -> Void) {
        
        guard let request = URL(string: requestString + geoCode ) else {
            print("Failed to make API URL")
            return
        }
        service.get(request: request) { result in
            switch result {
            case .success(let data):
                do {
                    let responseString = String (decoding: data, as:UTF8.self)
                    completion(.success(responseString))
                }
            case .error(let error):
                completion(.error(error))
            }
        }
    }
}
