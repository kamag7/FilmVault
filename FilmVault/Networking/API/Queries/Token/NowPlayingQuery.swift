//
//  NowPlayingQuery.swift
//  FilmVault
//
//  Created by magdalena.skawinska on 25/06/2023.
//

import Foundation

struct NowPlayingQuery: QueryProtocol {
    private enum Constant {
        static let apiKey = "api_key"
    }
    var method: HTTPMethod = .get
    var endpoint: EndpointProtocol = NowPlayingEndpoint()
    var service: NetworkServiceProtocol = NowPlayingService()
    var urlParameters: RequestUrlParameters?
    var httpParameters: HttpParameterType?
    var additionalHeaders: [HTTPHeaderField] = []

    init() {
        urlParameters = RequestUrlParameters(params: [Constant.apiKey: [Configuration.apiKey]])
    }
}

