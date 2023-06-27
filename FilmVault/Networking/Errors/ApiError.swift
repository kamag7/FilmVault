//
//  ApiError.swift
//  FilmVault
//
//  Created by magdalena.skawinska on 24/06/2023.
//

import Foundation

public enum ApiError: Error, Equatable {
case unauthorized
case forbidden
case notFound
case badRequest
case internalServerError
case decodingError
case unknown(message: String)
case noNetwork

    init(error: NetworkLayerError) {
        switch error {
        case .responseError(code: let code, message: let message):
            if code == 401 {
                self = .unauthorized
            } else if code == 403 {
                self = .forbidden
            } else if code == 404 {
                self = .notFound
            } else if code == 400 {
                self = .badRequest
            } else if code == 500 {
                self = .internalServerError
            } else {
                self = .unknown(message: message ?? "")
            }
        case .decodingError:
            self = .decodingError
        case .noNetwork:
            self = .noNetwork
        default:
            self = .unknown(message: error.localizedDescription)
        }
    }
}
