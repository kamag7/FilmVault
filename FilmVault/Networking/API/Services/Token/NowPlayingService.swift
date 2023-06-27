//
//  NowPlayingService.swift
//  FilmVault
//
//  Created by magdalena.skawinska on 25/06/2023.
//

import Foundation

struct NowPlayingService: NetworkServiceProtocol {
    var scheme: ServiceScheme = .https
    var host: String = Configuration.apiBaseStringUrl
    var root: String = ""
    var version: String = "3"
}
