//
//  UseCasesLocator.swift
//  PCWallbox
//
//  Created by Luis Cañadas Treceño on 9/3/22.
//

import Foundation

struct UseCasesLocator {
    let repositoriesLocator = RepositoriesLocator()

    func makeListUseCase() -> ListUseCase {
        let repository = repositoriesLocator.makeCharactersRepository()
        return ListUseCase(input: .empty, repository: repository)
    }

    func makeDetailUseCase() -> DetailUseCase {
        let repository = repositoriesLocator.makeCharactersRepository()
        return DetailUseCase(input: .empty, repository: repository)
    }
}
