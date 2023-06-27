//
//  TokenQuery.swift
//  FilmVault
//
//  Created by magdalena.skawinska on 24/06/2023.
//

import Foundation

struct TokenQuery: QueryProtocol {
    private enum Constant {
        static let apiKey = "api_key"
    }
    var method: HTTPMethod = .get
    var endpoint: EndpointProtocol = TokenEndpoint()
    var service: NetworkServiceProtocol = TokenService()
    var urlParameters: RequestUrlParameters?
    var httpParameters: HttpParameterType?
    var additionalHeaders: [HTTPHeaderField] = []

    init(tokenRequest: TokenRequest) {
        urlParameters = RequestUrlParameters(params: [Constant.apiKey: [tokenRequest.key]])
    }
}
