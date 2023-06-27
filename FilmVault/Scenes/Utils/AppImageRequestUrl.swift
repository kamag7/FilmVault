//
//  AppImageRequestUrl.swift
//  FilmVault
//
//  Created by magdalena.skawinska on 25/06/2023.
//

import Foundation
import UIKit

final class ImageRequestUrl {
    static func imageURL(imageStringUrl: String?) -> URL? {
        guard let imageUrl = imageStringUrl else {
            return nil
        }
        return URL(string: "https://image.tmdb.org/t/p/w500/" + imageUrl)
    }
}
