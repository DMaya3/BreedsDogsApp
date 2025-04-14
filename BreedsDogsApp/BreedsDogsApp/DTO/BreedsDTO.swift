//
//  BreedsDTO.swift
//  BreedsDogsApp
//
//  Created by David Jesús Maya Quirós on 11/4/25.
//

import Foundation

struct BreedsDTO: Codable {
    let message: [String: [String]]
    let status: String
}

struct Breed: Identifiable {
    var id: String { main }
    var main: String
    var subBreeds: [String]
}

struct SelectedBreed: Identifiable {
    var id: String { main }
    var main: String
    var sub: String
}

struct BreedImage: Codable {
    let message: [String]
    let status: String
}
