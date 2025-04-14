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
    func fetchBreedImageDataService(breedName: String) async -> AnyPublisher<BreedImage, Error>
}

struct BreedsDataRepository: BreedsRepository {
    var session: URLSession = URLSession.shared
    var baseUrl: String = "https://dog.ceo/api/"
    var bgQueue = DispatchQueue(label: "bg_parse_queue")
    
    func fetchAllBreedsDataService() async -> AnyPublisher<BreedsDTO, any Error> {
        return call(endpoint: API.allBreeds)
    }
    
    func fetchBreedImageDataService(breedName: String) async -> AnyPublisher<BreedImage, any Error> {
        return call(endpoint: API.breedImage(breedName: breedName))
    }
}

extension BreedsDataRepository {
    enum API {
        case allBreeds
        case breedImage(breedName: String)
    }
}

extension BreedsDataRepository.API: APICall {
    var path: String {
        switch self {
        case .allBreeds:
            return "breeds/list/all"
        case .breedImage(let breedName):
            return "breed/\(breedName)/images"
        }
    }
    
    var method: String {
        switch self {
        case .allBreeds, .breedImage:
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
