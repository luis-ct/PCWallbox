//
//  UseCasesLocator.swift
//  PCWallbox
//
//  Created by Luis Cañadas Treceño on 9/3/22.
//

import Foundation

struct UseCasesLocator {
    let repositoriesLocator = RepositoriesLocator()

    func makeTranslatorUseCase() -> UseCase<TranslateUseCaseInput, TranslateUseCaseOutput> {
        let repository = repositoriesLocator.makeTranslatorRepository()
        return TranslatorUseCase(input: "", repository: repository)
    }

    func makeLastTranslationUseCase() -> UseCase<Void, TranslateUseCaseOutput> {
        let repository = repositoriesLocator.makeTranslatorRepository()
        return LastTranslationUseCase(repository: repository)
    }

}
