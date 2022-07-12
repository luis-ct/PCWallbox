//
//  HomeViewModel.swift
//  PCWallbox
//
//  Created by Luis Cañadas Treceño on 6/3/22.
//

import Foundation
import Combine

class HomeItem: ObservableObject {
    @Published var text: String = ""
    @Published var state: StateViewModel<String> = .initial

    var tap: () -> () = {}
}

protocol HomeViewModelAbstractFactory {
    func makeTranslatorUseCase() -> UseCase<TranslateUseCaseInput, TranslateUseCaseOutput>
    func makeLastTranslationUseCase() -> UseCase<Void, TranslateUseCaseOutput>
}

class HomeViewModel: HomeViewModelProtocol {
    var item = HomeItem()
    var navigator: HomeNavigatorProtocol!

    private let useCase: UseCase<TranslateUseCaseInput, TranslateUseCaseOutput>
    private let lastTranslationUseCase: UseCase<Void, TranslateUseCaseOutput>

    init(
        abstractFactory: HomeViewModelAbstractFactory
    ) {
        self.useCase = abstractFactory.makeTranslatorUseCase()
        self.lastTranslationUseCase = abstractFactory.makeLastTranslationUseCase()

        item.tap = { [weak self] in
            self?.translateTapped()
        }
    }

    func viewDidLoad() {
        getLastTranslation()
    }

    private func translateTapped() {
        translate()
    }

    // MARK: - Last Translation
    private func getLastTranslation() {
        lastTranslationUseCase.output = { [weak self] result in
            switch result {
            case .success(let output):
                self?.getLastTranslationSuccess(output)
            case .failure(let error):
                self?.getLastTranslationFailure(error)
            }
        }
        lastTranslationUseCase.run()
    }

    private func getLastTranslationSuccess(_ output: String) {
        item.state = .success(output)
    }

    private func getLastTranslationFailure(_ error: Error) {
        item.state = .failure(error)
    }

    // MARK: - Translate
    private func translate() {
        item.state = .loading
        useCase.output = { [weak self] result in
            switch result {
            case .success(let output):
                self?.translateSuccess(output)
            case .failure(let error):
                self?.translateFailure(error)
            }
        }
        useCase.run()
    }

    private func translateSuccess(_ output: String) {
        item.state = .success(output)
    }

    private func translateFailure(_ error: Error) {
        item.state = .failure(error)
    }
}
