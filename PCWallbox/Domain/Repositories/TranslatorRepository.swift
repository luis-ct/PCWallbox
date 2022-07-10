//
//  TranslatorRepository.swift
//  PCWallbox
//
//  Created by Luis Cañadas Treceño on 6/3/22.
//

import Foundation
import Combine

protocol TranslatorRepositoryApiProtocol {
    func translate(text: String) -> AnyPublisher<String, Error>
}
protocol TranslatorRepositoryLocalProtocol {
    var translation: String { get set }
}

enum TranslatorRepositoryError: Error {
    case notFound
}

class TranslatorRepository {
    let api: TranslatorRepositoryApiProtocol
    var local: TranslatorRepositoryLocalProtocol

    init(
        api: TranslatorRepositoryApiProtocol,
        local: TranslatorRepositoryLocalProtocol
    ) {
        self.api = api
        self.local = local
    }
}

extension TranslatorRepository: TranslateRepositoryProtocol {
    func translate(text: String) -> AnyPublisher<String, Error> {
        return api.translate(text: text).compactMap { value in
            self.local.translation = value
            return value
        }
        .eraseToAnyPublisher()
    }
}

extension TranslatorRepository: LastTranslationRepositoryProtocol {
    func getLastTranslation() -> AnyPublisher<String, Never> {
        return Just(local.translation).eraseToAnyPublisher()
    }
}
