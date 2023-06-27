//
//  APIPluginProtocol.swift
//  FilmVault
//
//  Created by magdalena.skawinska on 24/06/2023.
//

import Foundation

public protocol APIPluginProtocol {
    func willSend(_ request: URLRequest?)
    func didReceive(_ response: URLResponse?, data: Data?, queryParams: QueryProtocol?)
}

