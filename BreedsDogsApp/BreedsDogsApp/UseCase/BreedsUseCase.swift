//
//  BreedsUseCase.swift
//  BreedsDogsApp
//
//  Created by David Jesús Maya Quirós on 11/4/25.
//

import Foundation
import Combine

protocol BreedsUseCase {
    func fetchDataBreeds() async -> AnyPublisher<BreedsDTO, Error>
}

struct DefaultBreedsUseCase: BreedsUseCase {
    private let repository = BreedsDataRepository()
    
    func fetchDataBreeds() async -> AnyPublisher<BreedsDTO, Error> {
        return await repository.fetchAllBreedsDataService()
    }
}
