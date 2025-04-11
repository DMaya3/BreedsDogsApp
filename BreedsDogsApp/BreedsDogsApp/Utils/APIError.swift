//
//  APIError.swift
//  BreedsDogsApp
//
//  Created by David Jesús Maya Quirós on 11/4/25.
//


import Foundation

enum APIError: Swift.Error, Codable {
    case invalidUrl
    case httpCode(HTTPCode)
    case unexpectedResponse
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidUrl: return "Invalid URL"
        case .httpCode(let code): return "Unexpected HTTP Code \(code)"
        case .unexpectedResponse: return "Unexpected response"
        }
    }
}