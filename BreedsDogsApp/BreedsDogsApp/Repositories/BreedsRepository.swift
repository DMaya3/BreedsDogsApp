//
//  BreedsRepository.swift
//  BreedsDogsApp
//
//  Created by David Jesús Maya Quirós on 11/4/25.
//

import Foundation
import Combine

protocol BreedsRepository: WebRepository {
    func fetchAllBreedsDataService() async -> AnyPublisher<BreedsDTO, Error>
}

struct BreedsDataRepository: BreedsRepository {
    var session: URLSession = URLSession.shared
    var baseUrl: String = "https://dog.ceo/api/"
    var bgQueue = DispatchQueue(label: "bg_parse_queue")
    
    func fetchAllBreedsDataService() async -> AnyPublisher<BreedsDTO, any Error> {
        return call(endpoint: API.allBreeds)
    }
}

extension BreedsDataRepository {
    enum API {
        case allBreeds
    }
}

extension BreedsDataRepository.API: APICall {
    var path: String {
        switch self {
        case .allBreeds:
            return "breeds/list/all"
        }
    }
    
    var method: String {
        switch self {
        case .allBreeds:
            return "GET"
        }
    }
    
    var headers: [String : String] {
        return ["Acept" : "application/json"]
    }
    
    func body() throws -> Data? {
        return nil
    }
}
