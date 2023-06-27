//
//  NetworkLogger.swift
//  FilmVault
//
//  Created by magdalena.skawinska on 24/06/2023.
//

import Foundation

public struct NetworkLogger {
//is really nedded?
    let isVerbose: Bool = true
    let loggerId: String = "[NetworkLogger]"
    private let separator: String = ", "
    private let terminator: String = "\n"
    //is separater terminator needed?
    private let output: (_ separator: String, _ terminator: String, _ items: Any...) -> Void = NetworkLogger.reversedPrint

    private let dateFormatter: DateFormatter

    private var date: String {
        dateFormatter.dateFormat = "dd/MM HH:mm:ss.SSS"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: Date())
    }

    public init(dateFormatter: DateFormatter = DateFormatter()) {
        self.dateFormatter = dateFormatter
    }

    func format(_ loggerId: String, date: String, identifier: String, message: String) -> String {
        return "\(loggerId): [\(date)] \(identifier): \(message)"
    }
}

private extension NetworkLogger {
    func logNetworkRequest(request: URLRequest?) -> [String] {
        var output = [String]()
        
        output.append(contentsOf: [format(loggerId, date: date, identifier: "Request", message: request?.description ?? "(invalid request)")])

        if let headers = request?.allHTTPHeaderFields {
            output.append(contentsOf: [format(loggerId, date: date, identifier: "Request Headers", message: headers.description)])
        }

        if let bodyStream = request?.httpBodyStream {
            output.append(contentsOf: [format(loggerId, date: date, identifier: "Request Body Stream", message: bodyStream.description)])
        }

        if let httpMethod = request?.httpMethod {
            output.append(contentsOf: [format(loggerId, date: date, identifier: "HTTP Request Method", message: httpMethod)])
        }

        if let body = request?.httpBody,
            let stringOutput = String(data: body, encoding: .utf8),
            isVerbose {
            output.append(contentsOf: [format(loggerId, date: date, identifier: "Request Body", message: stringOutput)])
        }

        return output
    }

    func logNetworkResponse(response: URLResponse?, data: Data?, query: QueryProtocol) -> [String] {

        guard let response = response else {
            return [format(loggerId,
                           date: date,
                           identifier: "Response",
                           message: "Received empty network response for query: \(query)")]
        }

        var output = [String]()

        output.append(contentsOf: [format(loggerId, date: date, identifier: "Response", message: response.description)])

        if let body = data,
            let stringOutput = String(data: body, encoding: .utf8),
            isVerbose {
            output.append(contentsOf: [format(loggerId, date: date, identifier: "Response Body", message: stringOutput)])
        }

        return output
    }

    func outputItems(_ items: [String]) {
        if isVerbose {
            items.forEach {
                output(separator, terminator, $0)
            }
        } else {
            output(separator, terminator, items)
        }
    }

    static func reversedPrint(_ separator: String, terminator: String, items: Any...) {
        for item in items.compactMap({ $0 as? String }) {
            print(item)
        }
    }
}

extension NetworkLogger: APIPluginProtocol {
    public func willSend(_ request: URLRequest?) {
        outputItems(logNetworkRequest(request: request))
    }

    public func didReceive(_ response: URLResponse?, data: Data?, queryParams: QueryProtocol?) {
        guard let query = queryParams else {
            return
        }
        outputItems(logNetworkResponse(response: response, data: data, query: query))
    }
}
