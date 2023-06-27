//
//  Token.swift
//  FilmVault
//
//  Created by magdalena.skawinska on 24/06/2023.
//

import Foundation

struct TokenResponse: Codable {
    let success: Bool
    let expiresAt: String
    let requestToken: String

    func isExpired() -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        guard let date = dateFormatter.date(from: expiresAt) else { return true }
        return date < Date() - 120
    }
}

struct TokenRequest: Codable {
    let key: String
}

