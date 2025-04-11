//
//  NetworkingHelpers.swift
//  BreedsDogsApp
//
//  Created by David Jesús Maya Quirós on 11/4/25.
//

import Foundation
import Combine

extension Publisher {
    func extractUnderlyingError() -> Publishers.MapError<Self, Failure> {
        mapError {
            ($0.underlyingError as? Failure) ?? $0
        }
    }
}

private extension Error {
    var underlyingError: Error? {
        let nsError = self as NSError
        if nsError.domain == NSURLErrorDomain && nsError.code == -1009 {
            return self
        }
        return nsError.userInfo[NSUnderlyingErrorKey] as? Error
    }
}

extension Subscribers.Completion {
    var error: Failure? {
        switch self {
        case .failure(let error): return error
        default: return nil
        }
    }
}
