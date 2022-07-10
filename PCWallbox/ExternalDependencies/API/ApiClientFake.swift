//
//  ApiClientFake.swift
//  PCWallbox
//
//  Created by Luis Cañadas Treceño on 9/3/22.
//

import Foundation
import Combine

struct ApiClientFake: ListRepositoryApiProtocol {
    func getCharacters() -> AnyPublisher<[Character], Error> {
        guard let url = Bundle.main.url(forResource: "characters", withExtension: "json") else {
            return Fail(error: URLError(URLError.notConnectedToInternet)).eraseToAnyPublisher()
        }
        do {
            let data = try Data(contentsOf: url)
            let response = try JSONDecoder().decode(CharacterResponse.self, from: data)

            return Deferred {
                return Future<[Character], Error> { promise in
                        promise(.success(response.results))
                }.delay(for: .init(3), tolerance: nil, scheduler: RunLoop.main, options: nil)
            }.eraseToAnyPublisher()
        } catch {
            return Fail(error: URLError(URLError.notConnectedToInternet)).eraseToAnyPublisher()
        }
    }

    func getCharacter(_ id: String) -> AnyPublisher<Character, Error> {
        guard let url = Bundle.main.url(forResource: "character", withExtension: "json") else {
            return Fail(error: URLError(URLError.notConnectedToInternet)).eraseToAnyPublisher()
        }
        do {
            let data = try Data(contentsOf: url)
            let response = try JSONDecoder().decode(CharacterResponse.self, from: data)

            return Deferred {
                return Future<Character, Error> { promise in
                    guard let character = response.results.first else {
                        promise(.failure(CharacterRepositoryError.notFound))
                        return
                    }
                    promise(.success(character))
                }.delay(for: .init(3), tolerance: nil, scheduler: RunLoop.main, options: nil)
            }.eraseToAnyPublisher()
        } catch {
            return Fail(error: URLError(URLError.notConnectedToInternet)).eraseToAnyPublisher()
        }
    }
}
