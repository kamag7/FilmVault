//
//  NetworkRequest.swift
//  FilmVault
//
//  Created by magdalena.skawinska on 24/06/2023.
//

import Foundation
import Combine

public typealias HTTPHeaderField = (value: String?, field: String)

public struct NetworkRequest {
    public struct Response<T> {
        let value: T
        let response: URLResponse
    }

    private let query: QueryProtocol
    private let session: URLSession
    private let logger: APIPluginProtocol

    public var headers: [HTTPHeaderField] = []

    public init(query: QueryProtocol, session: URLSession, logger: APIPluginProtocol = NetworkLogger()) {
        self.query = query
        self.session = session
        self.logger = logger
    }

    public func  run<T: Decodable>(_ decoder:JSONDecoder = JSONDecoder()) -> AnyPublisher<Response<T>, NetworkLayerError> {
        let request: URLRequest

        do {
            request = try foundationRequest(query: query, headers: headers)
        } catch {
            return Fail(error: NetworkLayerError.urlCreationError).eraseToAnyPublisher()
        }

        logger.willSend(request)

        return session.dataTaskPublisher(for: request)
            .tryMap { result -> Response<T> in
                self.logger.didReceive(result.response, data: result.data, queryParams: self.query)

                guard let httpResponse = result.response as? HTTPURLResponse else {
                    throw NetworkLayerError.noNetwork
                }

                guard (200...299).contains(httpResponse.statusCode) else {
                    throw NetworkLayerError(decoder: decoder, response: httpResponse, data: result.data)
                }

                let data = result.data.isEmpty ? "{}".data(using: .utf8) ?? Data() : result.data

                let value = try decoder.decode(T.self, from: data)

                return Response(value: value, response: result.response)
            }
            .mapError { error -> NetworkLayerError in
                switch error {
                case let error as NetworkLayerError:
                    return error
                case is DecodingError:
                    assertionFailure(error.localizedDescription)
                    return NetworkLayerError.decodingError
                default:
                    if let err = error as? URLError, err.code == .notConnectedToInternet {
                        return NetworkLayerError.noNetwork
                    } else {
                        return NetworkLayerError.internalError(description: error.localizedDescription)
                    }
                }
            }
            .eraseToAnyPublisher()
    }

}

extension NetworkRequest {
    func foundationRequest(query: QueryProtocol, headers: [HTTPHeaderField]) throws -> URLRequest {
        var components = URLComponents()
        components.scheme = query.service.scheme.rawValue
        components.host = query.service.host

        let pathElements = [query.service.version, query.service.root, query.endpoint.path]
        components.path = "/".appending(pathElements.filter {!$0.isEmpty}.joined(separator: "/"))

        let queryItems = query.urlParameters?.queryItems ?? []
        if !queryItems.isEmpty {
            components.queryItems = queryItems as [URLQueryItem]
            //This is needed because: According to RFC 3986, the plus sign is a valid character within a query, and doesn't need to be percent-encoded. However, according to the W3C recommendations for URI addressing, the plus sign is reserved as shorthand notation for a space within a query string
            components.percentEncodedQuery = components.percentEncodedQuery?
                .replacingOccurrences(of: "+", with: "%2B")
        }

        guard let url = components.url else {
            throw NetworkLayerError.urlCreationError
        }

        let mutableRequest = NSMutableURLRequest(url: url)
        mutableRequest.httpMethod = query.method.rawValue

        if let bodyParameters = query.httpParameters {
            switch bodyParameters {
            case .json(let params):
                mutableRequest.httpBody = params.body
                mutableRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .body(let params):
                mutableRequest.httpBody = params.httpBody
                mutableRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            }
        }

        for header in headers {
            mutableRequest.setValue(header.value, forHTTPHeaderField: header.field)
        }

        guard let immutableRequest = mutableRequest.copy() as? URLRequest else {
            return URLRequest(url: url)
        }

        return immutableRequest
    }
}
