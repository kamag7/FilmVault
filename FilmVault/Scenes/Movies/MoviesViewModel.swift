//
//  MoviesViewModel.swift
//  FilmVault
//
//  Created by magdalena.skawinska on 25/06/2023.
//

import Combine
import Foundation

final class MoviesViewModel {

    // MARK: Public properties
    @Published private(set) var movies: [Movie] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var error: ApiError?

    let loadDataSubject = PassthroughSubject<Void, Never>()
    private let moviesRepository: NowPlayingRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()

    init(moviesRepository: NowPlayingRepositoryProtocol = NowPlayingRepository()) {
        self.moviesRepository = moviesRepository
        bind()
    }

    private func bind() {
        loadDataSubject
            .receive(on: DispatchQueue.main)
            .map { _ in true}
            .assign(to: \.isLoading, on: self)
            .store(in: &cancellables)

        let moviesDataPublisher = loadDataSubject
            .flatMap { [weak self] in
                let response = self?.moviesRepository.getNowPlayingMovies()
                    .receive(on: DispatchQueue.main)
                    .catch { [weak self] error -> Empty<NowPlayingResponse, Never> in
                        self?.error = error
                        self?.isLoading = false
                        return Empty()
                    }
                return response.orEmpty()
            }
            .share()

        moviesDataPublisher
            .map { results in
                results.results
            }
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.isLoading = false
            })
            .assign(to: \.movies, on: self)
            .store(in: &cancellables)
    }
}
