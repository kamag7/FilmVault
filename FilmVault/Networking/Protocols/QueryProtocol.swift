//
//  QueryProtocol.swift
//  FilmVault
//
//  Created by magdalena.skawinska on 24/06/2023.
//

import Foundation

//Method for HTTP query
public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

public enum HttpParameterType {
    case json(parameters: RequestJsonParameters)
    case body(parameters: RequestBodyParameters)
}

//Protocol for query
public protocol QueryProtocol {
    var method: HTTPMethod { get }
    var endpoint: EndpointProtocol { get }
    var service: NetworkServiceProtocol { get }
    var urlParameters: RequestUrlParameters? { get set }
    var httpParameters: HttpParameterType? { get set }
    var additionalHeaders: [HTTPHeaderField] { get }
}
