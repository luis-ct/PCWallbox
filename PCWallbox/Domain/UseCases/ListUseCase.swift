//
//  ListUseCase.swift
//  PCWallbox
//
//  Created by Luis Cañadas Treceño on 6/3/22.
//

import Foundation
import Combine

struct ListUseCaseInput {
    static var empty = ListUseCaseInput()
}

typealias ListUseCaseOutput = [CharacterDO]

protocol ListRepositoryProtocol {
    func getCharacters() -> AnyPublisher<[CharacterDO], Error>
}

class ListUseCase {
    var input: ListUseCaseInput
    var output: ((Result<ListUseCaseOutput, Error>) -> ())?

    private var repository: ListRepositoryProtocol
    private var cancellables: Set<AnyCancellable> = Set()
    private var value: [CharacterDO] = []

    init(
        input: ListUseCaseInput,
        repository: ListRepositoryProtocol
    ) {
        self.input = input
        self.repository = repository
    }

    func run() {
        getCharacters()
    }

    private func getCharacters() {
        repository.getCharacters()
            .sink { [weak self] completion in
            switch completion {
            case .finished:
                self?.getCharactersFinished()
            case .failure(let error):
                self?.getCharactersFailure(error)
            }
        } receiveValue: { [weak self] value in
            self?.value = value
        }.store(in: &cancellables)
    }

    private func getCharactersFinished() {
        output?(.success(value))
    }

    private func getCharactersFailure(_ error: Error) {
        output?(.failure(error))
    }
}
