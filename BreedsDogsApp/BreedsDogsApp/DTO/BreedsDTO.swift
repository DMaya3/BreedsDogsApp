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
