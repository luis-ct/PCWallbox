//
//  LastTranslationUseCase.swift
//  PCWallbox
//
//  Created by Luis Cañadas on 10/7/22.
//

import Foundation
import Combine

protocol LastTranslationRepositoryProtocol {
    func getLastTranslation() -> AnyPublisher<String, Never>
}

class LastTranslationUseCase: UseCase<Void, TranslateUseCaseOutput> {
    private var repository: LastTranslationRepositoryProtocol
    private var cancellables: Set<AnyCancellable> = Set()
    private var translatedText: String = ""

    init(
        repository: LastTranslationRepositoryProtocol
    ) {
        self.repository = repository
        super.init(input: ())
    }

    override func run() {
        getLastTranslation()
    }

    private func getLastTranslation() {
        repository.getLastTranslation()
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
