//
//  MovieCollectionViewCell.swift
//  FilmVault
//
//  Created by magdalena.skawinska on 25/06/2023.
//

import Nuke
import UIKit

final class MovieCollectionViewCell: UICollectionViewCell {

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        return imageView
    }()

    let favouriteIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "heart")
        imageView.tintColor = .yellow
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: MovieCollectionViewCell.self,
                                                              action: #selector(favoriteIconTapped)))
        return imageView
    }()

    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupFavoriteIcon()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        setupFavoriteIcon()
    }

    func configure(with movie: Movie) {
        backgroundColor = .gray
        loadImage(from: movie.posterPath)
    }

    private func setup() {
        [imageView, activityIndicator].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.rightAnchor.constraint(equalTo: rightAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    private func setupFavoriteIcon() {
        imageView.addSubview(favouriteIcon)

        NSLayoutConstraint.activate([
            favouriteIcon.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 16),
            favouriteIcon.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: -16),
            favouriteIcon.heightAnchor.constraint(equalToConstant: 30),
            favouriteIcon.widthAnchor.constraint(equalToConstant: 30)
        ])
    }

    private func loadImage(from url: String) {
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

        activityIndicator.startAnimating()
        Nuke.loadImage(with: ImageRequestUrl.imageURL(imageStringUrl: url),
                       options: options,
                       into: imageView) { [weak self] _ in
            self?.activityIndicator.stopAnimating()
        }
    }

    @objc func favoriteIconTapped() {
        //TODO: implement favorite icon tapped
    }
}
