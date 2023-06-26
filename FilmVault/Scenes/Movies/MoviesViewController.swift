//
//  ViewController.swift
//  FilmVault
//
//  Created by magdalena.skawinska on 24/06/2023.
//

import UIKit
import Combine

class ViewController: UIViewController {
    var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovies()
    }

    func fetchMovies() {
        let nowPlayingRepository = NowPlayingRepository()
        nowPlayingRepository.getNowPlayingMovies()
            .receive(subscriber: DispatchQueue.main)
            .sink { movies in
                movies.results.forEach { movie in
                    print("title: \(movie.title)")
                }
            }
            .store(in: &cancellables)
    }
}

