//
//  BreedsViewModel.swift
//  BreedsDogsApp
//
//  Created by David Jesús Maya Quirós on 11/4/25.
//

import Combine
import Foundation

final class BreedsViewModel: ObservableObject {
    private var suscription = Set<AnyCancellable>()
    var isLoading: Bool = false
    @Published var breeds: BreedsDTO?
    @Published var breedImageUrl: URL?
    
    var breedsArray: [Breed] {
        breeds?.message.map { Breed(main: $0.key, subBreeds: $0.value) } ?? []
    }
    
    init() {
        Task {
            await self.fetchBreeds()
        }
    }
    
    func fetchBreeds() async {
        await self.suscribeBreeds()
    }
    
    func fetchBreedImage(breedName: String) async {
        await self.suscribeBreedImage(breedName: breedName)
    }
}

// MARK: - Fetch Data
extension BreedsViewModel {
    func breedsPublisher() async  -> AnyPublisher<BreedsDTO, Error> {
        self.isLoading = true
        return await self.useCase.fetchDataBreeds()
    }
    
    func suscribeBreeds() async {
        await self.breedsPublisher()
            .sink { [weak self] completion in
                self?.isLoading = false
                self?.handleCompletion(completion)
            } receiveValue: { [weak self] breeds in
                self?.isLoading = false
                self?.breeds = breeds
            }
            .store(in: &suscription)
    }
    
    func breedImagePublisher(breedName: String) async -> AnyPublisher<BreedImage, Error> {
        self.isLoading = true
        return await self.useCase.fetchDataImageBreed(breedName: breedName)
    }
    
    func suscribeBreedImage(breedName: String) async {
        await self.breedImagePublisher(breedName: breedName)
            .sink { [weak self] completion in
                self?.isLoading = false
                self?.handleCompletion(completion)
            } receiveValue: { [weak self] breedImage in
                self?.isLoading = false
                if let firstImageURL = breedImage.message.first {
                    self?.breedImageUrl = URL(string: firstImageURL)
                }
            }
            .store(in: &suscription)

    }
}

// MARK: - Handle Errors
extension BreedsViewModel {
    func handleCompletion(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("Error: \(error.localizedDescription)")
        }
    }
}

// MARK: - Dependencies
extension BreedsViewModel {
    private var useCase: BreedsUseCase {
        DefaultBreedsUseCase()
    }
}
