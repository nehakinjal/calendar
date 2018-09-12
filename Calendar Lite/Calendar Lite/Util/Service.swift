//
//  Service.swift
//  Calendar Lite
//
//  Created by Neha Dalal on 9/11/18.
//  Copyright © 2018 Neha Dalal. All rights reserved.
//

import Foundation

// MARK: - Networking - if you want to create your own service layer


protocol Service {
    func get(request: URL, completion: @escaping (Result<Data>) -> Void)
}

final class API {
    
    let service: Service
    
    static let baseWeatherURL: String = "https://api.darksky.net"
    static let weatherServiceKey: String = "3cea8c3cecae045f06eac1541e988f0e"
    static let geoCode:String = "37.8267,-122.4233"
    
    init(service: Service = NetworkService()) {
        self.service = service
    }
    
    static let getCurrentWeatherURL:String = "\(baseWeatherURL)/forecast/\(weatherServiceKey)/\(geoCode)"
    
    func currentWeatherAsync(requestString: String = API.getCurrentWeatherURL, _ completion: @escaping (Result<String>) -> Void) {

        guard let request = URL(string: requestString ) else {
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

final class NetworkService: Service {

    func get(request: URL, completion: @escaping (Result<Data>) -> Void) {
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.error(error))
                return
            }
            guard let data = data else {
                completion(.error(ServiceError.invalidData))
                return
            }
            completion(.success(data))
        }.resume()
    }
}

enum ServiceError: Error {
    case invalidData
}
