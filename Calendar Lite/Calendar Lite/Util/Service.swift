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

// Need to add more network errors here
enum ServiceError: Error {
    case invalidData
}
