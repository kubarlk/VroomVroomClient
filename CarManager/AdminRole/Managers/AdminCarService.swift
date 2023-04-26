//
//  NetworkManager.swift
//  CarManager
//
//  Created by Kirill Kubarskiy on 16.04.23.
//

import Foundation
import Combine

class AdminCarService {
    func getCars() -> AnyPublisher<[AdminCar], Error> {
            guard let url = URL(string: "YOUR_API_ENDPOINT_URL_HERE") else {
                return Fail(error: NSError(domain: "Invalid URL", code: 0, userInfo: nil)).eraseToAnyPublisher()
            }
            return URLSession.shared.dataTaskPublisher(for: url)
                .map(\.data)
                .decode(type: [AdminCar].self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
        }
}


