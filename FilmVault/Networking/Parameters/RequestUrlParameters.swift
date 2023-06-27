//
//  RequestUrlParameters.swift
//  FilmVault
//
//  Created by magdalena.skawinska on 24/06/2023.
//

import Foundation

public struct RequestUrlParameters {

    private var urlParameters: [String: [String]]

    var queryItems: [URLQueryItem] {
        var queryItems = [URLQueryItem]()

        if !urlParameters.isEmpty {
            for (key, value) in urlParameters {
                queryItems.append(contentsOf: value.map { URLQueryItem(name: key, value: $0) })
            }
        }
        return queryItems
    }

    public init(params: [String: [String]]) {
        self.urlParameters = params
    }
}

