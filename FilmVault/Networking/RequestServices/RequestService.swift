//
//  RequestService.swift
//  FilmVault
//
//  Created by magdalena.skawinska on 24/06/2023.
//

import Foundation
import Combine

protocol RequestServiceProtocol {
    func request<T: Decodable>(type: T.Type, query: QueryProtocol) -> AnyPublisher<NetworkRequest.Response<T>, ApiError>
}
