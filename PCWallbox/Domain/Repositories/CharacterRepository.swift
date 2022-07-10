//
//  CharacterRepository.swift
//  PCWallbox
//
//  Created by Luis Cañadas Treceño on 6/3/22.
//

import Foundation
import Combine

protocol ListRepositoryApiProtocol {
    func getCharacters() -> AnyPublisher<[Character], Error>
    func getCharacter(_ id: String) -> AnyPublisher<Character, Error>
}

enum CharacterRepositoryError: Error {
    case notFound
}

class CharacterRepository {
    let api: ListRepositoryApiProtocol

    init(
        api: ListRepositoryApiProtocol
    ) {
        self.api = api
    }
}

extension CharacterRepository: ListRepositoryProtocol {
    func getCharacters() -> AnyPublisher<[CharacterDO], Error> {
        return api.getCharacters()
            .compactMap { characters in
                return characters.compactMap { CharacterDO(id: "", image: $0.thumbnailUrl, name: $0.name) }
            }
            .eraseToAnyPublisher()
    }
}

extension CharacterRepository: DetailRepositoryProtocol {
    func getCharacter(id: String) -> AnyPublisher<CharacterDO, Error> {
        return api.getCharacter(id)
            .compactMap { character in
                CharacterDO(id: "", image: character.thumbnailUrl, name: character.name)
            }
            .eraseToAnyPublisher()

    }
}
