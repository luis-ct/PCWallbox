//
//  HomeViewModelAbstractFactoryStub.swift
//  PCWallboxTests
//
//  Created by Luis Cañadas on 12/7/22.
//

import Foundation
@testable import PCWallbox

protocol HomeViewModelAbstractFactoryState {
    var resultTranslator: Result<TranslateUseCaseOutput, Error> { get set }
    var resultLastTranslation: Result<TranslateUseCaseOutput, Error> { get set }
}

struct HomeViewModelAbstractFactoryStub: HomeViewModelAbstractFactory {
    let state: HomeViewModelAbstractFactoryState

    func makeTranslatorUseCase() -> UseCase<TranslateUseCaseInput, TranslateUseCaseOutput> {
        return TranslatorUseCaseStub(state: state)
    }

    func makeLastTranslationUseCase() -> UseCase<Void, TranslateUseCaseOutput> {
        return LastTranslationUseCase(state: state)
    }
}

private class TranslatorUseCaseStub: UseCase<TranslateUseCaseInput, TranslateUseCaseOutput> {
    let state: HomeViewModelAbstractFactoryState

    init(
        state: HomeViewModelAbstractFactoryState
    ) {
        self.state = state
        super.init(input: "")
    }

    override func run() {
        output?(state.resultTranslator)
    }
}

private class LastTranslationUseCase: UseCase<Void, TranslateUseCaseOutput> {
    let state: HomeViewModelAbstractFactoryState

    init(
        state: HomeViewModelAbstractFactoryState
    ) {
        self.state = state
        super.init(input: ())
    }

    override func run() {
        output?(state.resultLastTranslation)
    }
}
