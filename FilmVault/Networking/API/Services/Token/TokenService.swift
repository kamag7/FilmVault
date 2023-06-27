//
//  TokenService.swift
//  FilmVault
//
//  Created by magdalena.skawinska on 24/06/2023.
//

import Foundation

struct TokenService: NetworkServiceProtocol {
    let scheme: ServiceScheme = .https
    let host: String = Configuration.apiBaseStringUrl
    let root: String = ""
    var version: String = Configuration.apiVersion
}

