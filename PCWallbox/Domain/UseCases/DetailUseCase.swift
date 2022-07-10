//
//  DetailUseCase.swift
//  PCWallbox
//
//  Created by Luis Cañadas Treceño on 6/3/22.
//

import Foundation
import Combine

struct DetailUseCaseInput {
    let id: String
    static var empty = DetailUseCaseInput(id: "")
}

typealias DetailUseCaseOutput = CharacterDO

protocol DetailRepositoryProtocol {
    func getCharacter(id: String) -> AnyPublisher<CharacterDO, Error>
}

class DetailUseCase {
    var input: DetailUseCaseInput
    var output: ((Result<DetailUseCaseOutput, Error>) -> ())?

    private var repository: DetailRepositoryProtocol
    private var cancellables: Set<AnyCancellable> = Set()
    private var value: CharacterDO!

    init(
        input: DetailUseCaseInput,
        repository: DetailRepositoryProtocol
    ) {
        self.input = input
        self.repository = repository
    }

    func run() {
        getCharacter()
    }

    private func getCharacter() {
        repository.getCharacter(id: input.id)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.getCharacterFinished()
                case .failure(let error):
                    self?.getCharacterFailure(error)
                }
            } receiveValue: { [weak self] value in
                self?.value = value
            }.store(in: &cancellables)
    }

    private func getCharacterFinished() {
        output?(.success(value))
    }

    private func getCharacterFailure(_ error: Error) {
        output?(.failure(error))
    }
}
