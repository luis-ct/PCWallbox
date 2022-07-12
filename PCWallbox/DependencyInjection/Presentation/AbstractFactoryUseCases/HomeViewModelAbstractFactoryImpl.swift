//
//  HomeViewModelAbstractFactoryImpl.swift
//  PCWallbox
//
//  Created by Luis Cañadas on 12/7/22.
//

import Foundation

struct HomeViewModelAbstractFactoryImpl: HomeViewModelAbstractFactory {
    let useCasesLocator: UseCasesLocator

    func makeTranslatorUseCase() -> UseCase<TranslateUseCaseInput, TranslateUseCaseOutput> {
        return useCasesLocator.makeTranslatorUseCase()
    }

    func makeLastTranslationUseCase() -> UseCase<Void, TranslateUseCaseOutput> {
        return useCasesLocator.makeLastTranslationUseCase()
    }
}
