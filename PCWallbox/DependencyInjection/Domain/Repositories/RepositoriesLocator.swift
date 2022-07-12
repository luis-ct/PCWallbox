//
//  RepositoriesLocator.swift
//  PCWallbox
//
//  Created by Luis Cañadas Treceño on 9/3/22.
//

import Foundation

struct RepositoriesLocator {
    func makeTranslatorRepository() -> TranslatorRepository {
        return TranslatorRepository(api: ApiClientFake(), local: TranslatorLocal())
    }
}
