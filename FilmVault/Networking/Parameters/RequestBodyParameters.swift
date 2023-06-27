//
//  RequestBodyParameters.swift
//  FilmVault
//
//  Created by magdalena.skawinska on 24/06/2023.
//

import Foundation

public struct RequestBodyParameters {

    private var parameters: [String: [String]]

    var httpBody: Data? {
        var requestComponents = URLComponents()
        var queryItems = [URLQueryItem]()
        if !parameters.isEmpty {
            for (key, value) in parameters {
                queryItems.append(contentsOf: value.map { URLQueryItem(name: key, value: $0) })
            }
            requestComponents.queryItems = queryItems
        }
        return requestComponents.query?.data(using: .utf8, allowLossyConversion: false)
    }

    public init(params: [String: [String]]) {
        self.parameters = params
    }
}

