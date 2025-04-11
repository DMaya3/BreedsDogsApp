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
    
    init() {
        Task {
            await self.fetchBreeds()
        }
    }
    
    func fetchBreeds() async {
        await self.suscribeBreeds()
    }
}

// MARK: - Fetch Data
extension BreedsViewModel {
    func breendsPublisher() async  -> AnyPublisher<BreedsDTO, Error> {
        self.isLoading = true
        return await self.useCase.fetchDataBreeds()
    }
    
    func suscribeBreeds() async {
        await self.breendsPublisher()
            .sink { [weak self] completion in
                self?.isLoading = false
                self?.handleCompletion(completion)
            } receiveValue: { [weak self] breeds in
                self?.isLoading = false
                self?.breeds = breeds
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
