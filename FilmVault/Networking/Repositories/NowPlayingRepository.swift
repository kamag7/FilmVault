//
//  NowPlayingRepository.swift
//  FilmVault
//
//  Created by magdalena.skawinska on 25/06/2023.
//

import Combine
import Foundation

protocol NowPlayingRepositoryProtocol {
    func getNowPlayingMovies() -> AnyPublisher<NowPlayingResponse, ApiError>
}

final class NowPlayingRepository: NowPlayingRepositoryProtocol {
    private let requestService: RequestServiceProtocol

    init(requestService: RequestServiceProtocol = FreeSessionRequestService()) {
        self.requestService = requestService
    }

    func getNowPlayingMovies() -> AnyPublisher<NowPlayingResponse, ApiError> {
        let query = NowPlayingQuery()
        return requestService.request(type: NowPlayingResponse.self, query: query)
            .tryMap { data in
                NowPlayingResponse(dates: data.value.dates,
                                   page: data.value.page,
                                   results: data.value.results) }
            .mapError { error -> ApiError in
                error as? ApiError ?? .unknown(message: "Fetching movies failed")
            }
            .eraseToAnyPublisher()
    }
}


