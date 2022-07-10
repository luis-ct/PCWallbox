//
//  ApiClientFake.swift
//  PCWallbox
//
//  Created by Luis Cañadas Treceño on 9/3/22.
//

import Foundation
import Combine

struct ApiClientFake: TranslatorRepositoryApiProtocol {
    func translate(text: String) -> AnyPublisher<String, Error> {
        return Deferred {
            return Future<String, Error> { promise in
                promise(.success(String.random(of: 5)))
            }.delay(for: .init(3), tolerance: nil, scheduler: RunLoop.main, options: nil)
        }.eraseToAnyPublisher()
    }
}

private extension String {
   static func random(of n: Int) -> String {
      let digits = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
      return String(Array(0..<n).map { _ in digits.randomElement()! })
   }
}
