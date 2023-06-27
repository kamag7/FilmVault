//
//  KeychainService.swift
//  FilmVault
//
//  Created by magdalena.skawinska on 25/06/2023.
//

import Foundation
import KeychainAccess

struct KeychainService {
    private let keychain: Keychain = Keychain(service: "filmV.networking")

    func storeValue(_ value: String, for key: StoredValueKey) {
        do {
            try keychain.set(value, key: key.rawValue)
        } catch {
            print("Unable store value in keychain \(error.localizedDescription)")
        }
    }

    func getValue(for key: StoredValueKey) -> String? {
        do {
            return try keychain.get(key.rawValue)
        } catch {
            print("Unable get value from keychain \(error.localizedDescription)")
            return nil
        }
    }

    func modificationDateToken() -> Date? {
        keychain[attributes: StoredValueKey.accessToken.rawValue]?.modificationDate
    }
}

extension KeychainService {
    enum StoredValueKey: String, CaseIterable {
        case accessToken
        case sessionId
        case userId
    }
}

extension KeychainService {
    func removeAllValues() {
        StoredValueKey.allCases.forEach { key in
            try? keychain.remove(key.rawValue)
        }
    }
}
