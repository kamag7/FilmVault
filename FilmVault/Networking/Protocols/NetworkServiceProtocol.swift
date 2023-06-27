//
//  NetworkServiceProtocol.swift
//  FilmVault
//
//  Created by magdalena.skawinska on 24/06/2023.
//

import Foundation

public enum ServiceScheme: String {
    case http
    case https
}

//Protocol network service
public protocol NetworkServiceProtocol {
    var scheme: ServiceScheme { get }
    var host : String { get }
    var root: String { get }
    var version: String { get set }
}
