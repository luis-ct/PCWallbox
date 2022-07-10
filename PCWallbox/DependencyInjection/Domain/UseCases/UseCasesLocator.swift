//
//  UseCasesLocator.swift
//  PCWallbox
//
//  Created by Luis Cañadas Treceño on 9/3/22.
//

import Foundation

struct UseCasesLocator {
    let repositoriesLocator = RepositoriesLocator()

    func makeTranslateUseCase() -> UseCase<TranslateUseCaseInput, TranslateUseCaseOutput> {
        let repository = repositoriesLocator.makeCharactersRepository()
        return TranslateUseCase(input: "", repository: repository)
    }

    func makeLastTranslationUseCase() -> UseCase<Void, TranslateUseCaseOutput> {
        let repository = repositoriesLocator.makeCharactersRepository()
        return LastTranslationUseCase(repository: repository)
    }

}
