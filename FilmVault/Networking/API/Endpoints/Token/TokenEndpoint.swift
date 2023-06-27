//
//  TokenEndpoint.swift
//  FilmVault
//
//  Created by magdalena.skawinska on 24/06/2023.
//

import Foundation

struct TokenEndpoint: EndpointProtocol {
    var path: String {
        "/authentication/token/new"
    }
}
