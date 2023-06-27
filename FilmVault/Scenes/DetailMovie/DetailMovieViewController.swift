//
//  DetailMovieViewController.swift
//  FilmVault
//
//  Created by magdalena.skawinska on 25/06/2023.
//

import Foundation
import UIKit
import Nuke

final class DetailMovieViewController: UIViewController {
    private var viewModel: DetailMovieViewModel

    init(viewModel: DetailMovieViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        setupBackButton()
        configureView()
    }

    private func configureView() {
        let movieTitleLabel = UILabel()
        movieTitleLabel.text = viewModel.movie.title
        movieTitleLabel.textColor = .white
        movieTitleLabel.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        movieTitleLabel.textAlignment = .left
        movieTitleLabel.numberOfLines = 2
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(movieTitleLabel)

        let movieImageView = UIImageView()
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        loadImage(from: viewModel.movie.posterPath,
                  imageView: movieImageView)
        view.addSubview(movieImageView)

        let movieOverviewLabel = UILabel()
        movieOverviewLabel.text = viewModel.movie.overview
        movieOverviewLabel.textColor = .white
        movieOverviewLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        movieOverviewLabel.textAlignment = .left
        movieOverviewLabel.numberOfLines = 0
        movieOverviewLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(movieOverviewLabel)

        NSLayoutConstraint.activate([
            movieTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            movieTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            movieTitleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            movieImageView.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 16),
            movieImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            movieOverviewLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 16),
            movieOverviewLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            movieOverviewLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            movieOverviewLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])

    }

    private func loadImage(from url: String, imageView: UIImageView) {
        let options = ImageLoadingOptions(
            transition: .fadeIn(duration: 0.3),
            failureImage: UIImage(systemName: "film"),
            contentModes: ImageLoadingOptions.ContentModes(
                success: .scaleToFill,
                failure: .scaleAspectFit,
                placeholder: .scaleAspectFit
            ),
            tintColors: ImageLoadingOptions.TintColors(
                success: nil,
                failure: UIColor.black,
                placeholder: UIColor.white
            )
        )
        Nuke.loadImage(with: ImageRequestUrl.imageURL(imageStringUrl: url),
                       options: options,
                       into: imageView)
    }

    func setupBackButton() {
        //TODO: implement back button
    }
}
