//
//  FreeSessionRequestService.swift
//  FilmVault
//
//  Created by magdalena.skawinska on 25/06/2023.
//

import Foundation
import Combine

final class FreeSessionRequestService: RequestServiceProtocol {
    private let urlSession = URLSession(configuration: .ephemeral)

    let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    func request<T: Decodable>(type: T.Type, query: QueryProtocol) -> AnyPublisher<NetworkRequest.Response<T>, ApiError> {
        var request = NetworkRequest(query: query, session: urlSession)
        request.headers.append(contentsOf: query.additionalHeaders)
        return request.run(decoder)
            .mapError { ApiError(error: $0) }
            .eraseToAnyPublisher()
    }
}
