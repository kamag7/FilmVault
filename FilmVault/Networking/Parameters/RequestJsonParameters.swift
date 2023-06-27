//
//  RequestJsonParameters.swift
//  FilmVault
//
//  Created by magdalena.skawinska on 24/06/2023.
//

import Foundation

public struct RequestJsonParameters {

    private var internalStorage = [String: Any]()

    var body: Data? {
        guard JSONSerialization.isValidJSONObject(internalStorage) else {
            return nil
        }
        return try? JSONSerialization.data(withJSONObject: internalStorage, options: .prettyPrinted)
    }

    public init(params: [String: Any]) {
        self.internalStorage = params
    }

    subscript(key: String) -> Any? {
        get { return internalStorage[key] }
        set(value) {internalStorage[key] = value }
    }
}

