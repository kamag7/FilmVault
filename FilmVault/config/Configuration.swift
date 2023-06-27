//
//  Configuration.swift
//  FilmVault
//
//  Created by magdalena.skawinska on 24/06/2023.
//

import Foundation

enum Configuration {

    static var apiBaseStringUrl: String {
        string(for: "API_BASE_URL")
    }

    static var apiKey: String {
        string(for: "API_KEY")
    }

    static var apiVersion: String {
        string(for: "API_VERSION")
    }

    static private func string(for key: String) -> String {
        return Bundle.main.infoDictionary?[key] as! String
    }
}
