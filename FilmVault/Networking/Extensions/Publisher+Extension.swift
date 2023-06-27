//
//  Publisher+Extension.swift
//  FilmVault
//
//  Created by magdalena.skawinska on 25/06/2023.
//

import Combine

extension Optional where Wrapped: Combine.Publisher {
    func orEmpty() -> AnyPublisher<Wrapped.Output, Wrapped.Failure> {
        self?.eraseToAnyPublisher() ?? Empty().eraseToAnyPublisher()
    }
}

public extension AnyPublisher {
    static func just(_ output: Output) -> Self {
        Just(output)
            .setFailureType(to: Failure.self)
            .eraseToAnyPublisher()
    }

    static func fail(with error: Failure) -> Self {
        Fail(error: error)
            .eraseToAnyPublisher()
    }
}
