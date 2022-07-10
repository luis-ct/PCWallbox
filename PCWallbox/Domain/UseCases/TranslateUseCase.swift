//
//  TranslateUseCase.swift
//  PCWallbox
//
//  Created by Luis Cañadas Treceño on 6/3/22.
//

import Foundation
import Combine

typealias TranslateUseCaseInput = String
typealias TranslateUseCaseOutput = String

protocol TranslateRepositoryProtocol {
    func translate(text: String) -> AnyPublisher<String, Error>
}

class TranslateUseCase: UseCase<TranslateUseCaseInput, TranslateUseCaseOutput> {
    private var repository: TranslateRepositoryProtocol
    private var cancellables: Set<AnyCancellable> = Set()
    private var translatedText: String = ""

    init(
        input: TranslateUseCaseInput,
        repository: TranslateRepositoryProtocol
    ) {
        self.repository = repository
        super.init(input: input)
    }

    override func run() {
        translate()
    }

    private func translate() {
        repository.translate(text: input)
            .sink { [weak self] completion in
            switch completion {
            case .finished:
                self?.translateFinished()
            case .failure(let error):
                self?.translateFailure(error)
            }
        } receiveValue: { [weak self] value in
            self?.translatedText = value
        }.store(in: &cancellables)
    }

    private func translateFinished() {
        finish(result: .success(translatedText))
    }

    private func translateFailure(_ error: Error) {
        finish(result: .failure(error))
    }
}
