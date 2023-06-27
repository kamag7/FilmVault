//
//  NetworkLayerError.swift
//  FilmVault
//
//  Created by magdalena.skawinska on 24/06/2023.
//

import Foundation

public enum NetworkLayerError: Error {
    case responseError(code: Int, message: String?)
    case internalError(description: String?)
    case urlCreationError
    case decodingError
    case noNetwork
}

extension NetworkLayerError {

    init(decoder: JSONDecoder, response: HTTPURLResponse, data: Data?) {
        let message: String?
        if let data = data {
            let error = try? decoder.decode(NetworkError.self, from: data)
            message = error?.statusMessage
        } else {
            message = HTTPURLResponse.localizedString(forStatusCode: response.statusCode)
        }

        self = .responseError(code: response.statusCode, message: message)
    }
}

private struct NetworkError: Decodable {
    private enum CodingKeys: String, CodingKey {
        //is really needed
        case statusMessage = "status_message"
        case statusCode = "status_code"
        case success
    }

    let statusMessage: String?
    let statusCode: Int
    let success: Bool
}
